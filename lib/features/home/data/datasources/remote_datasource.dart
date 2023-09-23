import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource {
  static Future<Uint8List?> downloadFile({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        debugPrint('code: ${response.statusCode}, res: ${response.toString()}');
        return null;
      }

      return response.bodyBytes;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
