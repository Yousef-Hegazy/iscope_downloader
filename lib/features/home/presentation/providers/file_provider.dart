import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/domain/usecases/pick_excel_file_usecase.dart';

class FileNotifier extends StateNotifier<String?> {
  FileNotifier() : super(null);

  Future<String?> getFilePath() async {
    final PlatformFile? file = await PickExcelFileUseCase.call();

    if (file == null) {
      state = null;
      return null;
    }

    state = file.path;
    return file.path;
  }
}

final fileProvider =
    StateNotifierProvider<FileNotifier, String?>((ref) => FileNotifier());
