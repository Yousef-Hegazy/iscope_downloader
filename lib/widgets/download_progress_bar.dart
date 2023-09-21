import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/providers/file_download_provider.dart';

class DownloadProgressBar extends ConsumerWidget {
  const DownloadProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(fileDownloadProvider).progress;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blue),
            ),
            child: LinearProgressIndicator(
              minHeight: 35,
              value: progress,
              // borderRadius: BorderRadius.circular(6),
              backgroundColor: Colors.white,
              semanticsLabel: "Loader",
            ),
          ),
          Text(
            '${(progress * 100).toStringAsFixed(2)} %',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
