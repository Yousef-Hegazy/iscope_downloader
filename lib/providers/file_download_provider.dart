import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:iscope_downloader/constants.dart';

class DownloadStatus {
  final bool loading;
  final double progress;

  const DownloadStatus({required this.loading, required this.progress});

  DownloadStatus copyWith({bool? loading, double? progress}) {
    return DownloadStatus(
        loading: loading ?? this.loading, progress: progress ?? this.progress);
  }
}

class DownloadFileNotifier extends StateNotifier<DownloadStatus> {
  DownloadFileNotifier()
      : super(const DownloadStatus(loading: false, progress: 0.0));

  void resetDownloadStatus() {
    state = const DownloadStatus(loading: false, progress: 0.0);
  }

  void _setCurrentState(double currentPercentage) {
    if (currentPercentage >= 1.0) {
      state = DownloadStatus(loading: false, progress: currentPercentage);
    } else {
      state = state.copyWith(progress: currentPercentage);
    }
  }

  Future<void> downloadFile({
    required String url,
    required String filePath,
    required double currentPercentage,
    required Function(String message) log,
  }) async {
    try {
      final file = File(filePath);

      if (currentPercentage < 1.0 && state.loading == false) {
        state = state.copyWith(loading: true);
      }

      if (await file.exists()) {
        log('$filePath already exists\n$logSeparator');
        _setCurrentState(currentPercentage);
        return;
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
      }

      _setCurrentState(currentPercentage);
      log('$filePath Done\n$logSeparator');
    } catch (e) {
      debugPrint(e.toString());
      _setCurrentState(currentPercentage);
      log('Failed to download $filePath\n$logSeparator');
      return;
    }
  }
}

final fileDownloadProvider =
    StateNotifierProvider<DownloadFileNotifier, DownloadStatus>(
        (ref) => DownloadFileNotifier());
