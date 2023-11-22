import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:iscope_downloader/features/home/data/datasources/remote_datasource.dart';
import 'package:iscope_downloader/features/home/domain/entities/project_data_entity.dart';

class GetProjectsDataUseCase {
  static Future<List<ProjectDataEntity>> excelFileSource({
    required String? filePath,
  }) async {
    if (filePath == null || filePath.isEmpty) return [];

    try {
      final Uint8List bytes = await File(filePath).readAsBytes();
      final Excel excel = Excel.decodeBytes(bytes);
      final sheet = excel.tables['Sheet1']!;
      // final columnsList = sheet.row(0).map((cell) => '${cell?.value}').toList();
      final List<ProjectDataEntity> projectsList = List.generate(6, (i) {
        final List<Data> row = sheet.row(i + 1).cast();

        return ProjectDataEntity(
          projectId: int.parse(row[0].value.toString()),
          projectName: row[1].value.toString(),
          projectCode: row[2].value.toString(),
          contactNumber: row[3].value.toString(),
          documentCode: row[4].value.toString(),
          mFilePass: row[5].value.toString(),
          documentName: row[6].value.toString(),
          documentUrl: row[7].value.toString(),
          documentFileName: row[8].value.toString(),
          documentProcessStartDate: row[9].value.toString(),
          documentProcessEndDate: row[10].value.toString(),
          documentProcessDuration: row[11].value.toString().isEmpty
              ? null
              : int.parse(row[11].value.toString()),
          documentProcessCost: row[12].value.toString().isEmpty
              ? null
              : double.parse(row[12].value.toString()),
        );
      }, growable: false);

      return projectsList;
    } catch (e) {
      debugPrint('excelFileSource: ${e.toString()}');
      return [];
    }
  }

  static Future<List<ProjectDataEntity>> remoteSource() async {
    try {
      var projectsList = await RemoteDataSource.fetchProjectsData();

      if (projectsList.isEmpty) return [];

      return projectsList
          .map(
            (project) => ProjectDataEntity(
              projectId: project.projectId,
              projectName: project.projectName,
              projectCode: project.projectCode,
              contactNumber: project.contactNumber,
              documentCode: project.documentCode,
              projectDocumentId: project.projectDocumentId,
              codeOutSystemClass: project.codeOutSystemClass,
              mFilePass: project.mFilePass,
              documentName: project.documentName,
              documentUrl: project.documentUrl,
              documentFileName: project.documentFileName,
              documentProcessStartDate: project.documentProcessStartDate,
              documentProcessEndDate: project.documentProcessEndDate,
              documentProcessDuration: project.documentProcessDuration,
              documentProcessCost: project.documentProcessCost,
              codeEtimad: project.codeEtimad,
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('remoteSource: ${e.toString()}');
      return [];
    }
  }
}
