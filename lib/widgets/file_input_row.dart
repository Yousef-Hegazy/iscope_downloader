import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/providers/file_download_provider.dart';
import 'package:iscope_downloader/providers/file_provider.dart';
import 'package:iscope_downloader/providers/log_provider.dart';

class FileInputRow extends ConsumerStatefulWidget {
  const FileInputRow({super.key});

  @override
  ConsumerState<FileInputRow> createState() => _FileInputRowState();
}

class _FileInputRowState extends ConsumerState<FileInputRow> {
  final TextEditingController _controller = TextEditingController();

  void _handlePickFile() async {
    try {
      String? file = await ref.read(fileProvider.notifier).getFilePath();

      if (file is String) {
        _controller.text = file;
        ref.read(fileDownloadProvider.notifier).resetDownloadStatus();
        ref.read(logProvider.notifier).resetLog();
      } else {
        _controller.text = '';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.blueGrey.shade200,
                  ),
                ),
                fillColor: Colors.grey.shade300,
                filled: true,
                labelText: "الملف",
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.file_open_rounded),
            onPressed: _handlePickFile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            label: const Text(
              "تصفح",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
