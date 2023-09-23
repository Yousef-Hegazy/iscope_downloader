import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:iscope_downloader/features/home/domain/entities/project_data_entity.dart';

class GetProjectsDataUseCase {
  static Future<List<ProjectDataEntity>?> excelFileSource({
    required String filePath,
  }) async {
    if (filePath.isEmpty) return null;

    final Uint8List bytes = await File(filePath).readAsBytes();
    final Excel excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables['Sheet1']!;
    final columnsList = sheet.row(0).map((cell) => '${cell?.value}').toList();
    final List<ProjectDataEntity> projectsList = List.generate(8, (i) {
      final List<Data> row = sheet.row(i + 1).cast();

      final url = row[7].value.toString();
      final fileName = row[8].value.toString();

      final Map<String, String> values = {};

      row.asMap().forEach(
          (key, value) => values[columnsList[key]] = value.value.toString());

      return ProjectDataEntity(url: url, fileName: fileName, otherData: values);
    }, growable: false);

    return projectsList;
  }
}
