import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:iscope_downloader/constants.dart';
import 'package:iscope_downloader/features/home/data/datasources/remote_datasource.dart';
import 'package:iscope_downloader/features/home/domain/entities/project_data_entity.dart';
import 'package:pool/pool.dart';
import 'package:xml/xml.dart';

enum DataSources {
  excel,
  database,
}

class DownloadRes {
  String message;
  bool status;

  DownloadRes({required this.message, required this.status});
}

class DownloadAndCreateXmlUseCase {
  final String downloadDirectory;
  final List<ProjectDataEntity> projects;
  final void Function(String message) logMessage;

  const DownloadAndCreateXmlUseCase({
    required this.downloadDirectory,
    required this.logMessage,
    required this.projects,
  });

  Future<String> _createXml(ProjectDataEntity project) async {
    try {
      final xmlFile = File(
          '$downloadDirectory\\${project.documentFileName?.split('.')[0]}.xml');

      if (await xmlFile.exists()) {
        return '$logSeparator\n${xmlFile.path} already exists';
      }

      final XmlBuilder builder = XmlBuilder();

      project.toMap().forEach((key, value) async {
        builder.element(key, nest: () {
          if (value == null ||
              (value is String && value.isEmpty) ||
              (value is int && value == 0) ||
              (value is double && value == 0.0)) return;
          builder.text(value.toString());
        });
      });

      final XmlDocument xmlDocument = builder.buildDocument();

      final xmlString = xmlDocument.toXmlString(pretty: true);

      await xmlFile.writeAsString(
          "<?xml version='1.0' encoding='utf-8'?>\n<data>\n<row>$xmlString\n</row>\n</data>");

      return '$logSeparator\n${xmlFile.path} Done';
    } catch (e) {
      debugPrint('failed to create xml: ${e.toString()}');
      return e.toString();
    }
  }

  Future<DownloadRes> _downloadFile(ProjectDataEntity project) async {
    final downloadRes = DownloadRes(message: "", status: false);
    try {
      final downloadFile =
          File('$downloadDirectory\\${project.documentFileName}');

      if (await downloadFile.exists()) {
        downloadRes.message = '${downloadFile.path} already exists';
        downloadRes.status = false;
        return downloadRes;
      }

      final Uint8List? fileBytes =
          await RemoteDataSource.downloadFile(url: project.documentUrl);

      if (fileBytes == null) {
        downloadRes.message =
            'Failed to download file from ${project.documentUrl}';
        downloadRes.status = false;
        return downloadRes;
      }

      await downloadFile.writeAsBytes(fileBytes);

      downloadRes.message = '${downloadFile.path} Done';
      downloadRes.status = true;
      return downloadRes;
    } catch (e) {
      debugPrint('failed to download file: ${e.toString()}');
      downloadRes.message = e.toString();
      downloadRes.status = false;
      return downloadRes;
    }
  }

  Future<void> call({required VoidCallback increaseProgress}) async {
    if (projects.isEmpty) return;
    if (downloadDirectory.isEmpty) return;

    if (!(await Directory(downloadDirectory).exists())) {
      await Directory(downloadDirectory).create();
    }

    final pool = Pool(10);

    final futuresList = projects.map((project) async {
      await pool.withResource(() async {
        final downloadRes = await _downloadFile(project);
        if (downloadRes.status) {
          final xmlLog = await _createXml(project);
          logMessage('$xmlLog\n${downloadRes.message}');
        } else {
          logMessage('$logSeparator\n${downloadRes.message}');
        }

        increaseProgress();
      });
    });

    await Future.wait(futuresList);
  }
}
