import 'package:file_picker/file_picker.dart';
import 'package:iscope_downloader/features/home/data/datasources/local_datasource.dart';

class PickExcelFileUseCase {
  static Future<PlatformFile?> call() async {
    try {
      PlatformFile? file = await LocalDataSource.pickFile(
        type: FileType.custom,
        extensions: ['xlsx'],
      );

      return file;
    } catch (e) {
      return null;
    }
  }
}
