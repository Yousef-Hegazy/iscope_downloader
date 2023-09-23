import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/presentation/providers/download_and_create_xml_provider.dart';

class DownloadProgressBar extends ConsumerWidget {
  const DownloadProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(downloadAndCreateXmlProvider).progress;
    final total = ref.watch(downloadAndCreateXmlProvider).total;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blue),
          ),
          child: LinearProgressIndicator(
            minHeight: 35,
            value: progress / total,
            backgroundColor: Colors.white,
            semanticsLabel: "Loader",
          ),
        ),
        Text(
          '${((progress / total) * 100).toStringAsFixed(2)} %',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
