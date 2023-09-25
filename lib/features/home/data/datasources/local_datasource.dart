import 'package:file_picker/file_picker.dart';

class LocalDataSource {
  static Future<PlatformFile?> pickFile(
      {FileType? type, List<String>? extensions}) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type ?? FileType.any,
      allowedExtensions: extensions ?? ['*'],
    );

    if (result == null) return null;
//
    return result.files.first;
  }
}
