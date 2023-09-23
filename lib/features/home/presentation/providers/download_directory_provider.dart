import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/constants.dart';

class DownloadDirectoryNotifier extends StateNotifier<String> {
  DownloadDirectoryNotifier() : super(initialDownloadDirectory);

  Future<void> setDownloadDirectory(String path) async {
    if (path == state) return;
    if (path.isEmpty) {
      state = initialDownloadDirectory;
      return;
    }

    if (!(await Directory(path).exists())) {
      await Directory(path).create();
    }

    state = path;
  }
}

final downloadDirectoryProvider =
    StateNotifierProvider<DownloadDirectoryNotifier, String>(
        (ref) => DownloadDirectoryNotifier());
