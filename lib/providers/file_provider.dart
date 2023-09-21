import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileNotifier extends StateNotifier<PlatformFile?> {
  FileNotifier() : super(null);

  Future<String?> getFilePath() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result?.files.first.name is String) {
        PlatformFile file = result!.files.first;
        state = file;
        return file.path!;
      } else {
        state = null;
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      state = null;
      return null;
    }
  }
}

final fileProvider =
    StateNotifierProvider<FileNotifier, PlatformFile?>((ref) => FileNotifier());
