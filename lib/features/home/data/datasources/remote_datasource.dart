import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:iscope_downloader/features/home/data/models/project_data_model.dart';

class RemoteDataSource {
  static Future<Uint8List?> downloadFile({required String? url}) async {
    if (url == null || url.isEmpty) return null;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        debugPrint('code: ${response.statusCode}, res: ${response.toString()}');
        return null;
      }

      return response.bodyBytes;
    } catch (e) {
      debugPrint('downloadFile: ${e.toString()}');
      return null;
    }
  }

  static Future<List<ProjectDataModel>> fetchProjectsData() async {
    try {
      final response = await http
          .get(Uri.parse("https://localhost:7026/api/ProjectsDocuments"));

      if (response.statusCode != 200) {
        debugPrint(
            'code ${response.statusCode}, res: ${response.body.toString()}');
        return [];
      }

      final body = jsonDecode(response.body) as List<dynamic>;
      final documents = body.map((e) => ProjectDataModel.fromMap(e)).toList();

      return documents;
    } catch (e) {
      debugPrint('fetchProjectsData: ${e.toString()}');
      return [];
    }
  }
}