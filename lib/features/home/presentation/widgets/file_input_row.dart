import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/domain/usecases/download_and_create_xml_usecase.dart';
import 'package:iscope_downloader/features/home/presentation/providers/providers.dart';
import 'package:iscope_downloader/features/home/presentation/widgets/data_source_input.dart';

class FileInputRow extends ConsumerStatefulWidget {
  const FileInputRow({super.key});

  @override
  ConsumerState<FileInputRow> createState() => _FileInputRowState();
}

class _FileInputRowState extends ConsumerState<FileInputRow> {
  final TextEditingController _controller = TextEditingController();

  void _handlePickFile() async {
    try {
      String? filePath = await ref.read(fileProvider.notifier).getFilePath();

      if (filePath == null || filePath.isEmpty) {
        _controller.text = '';
      } else {
        _controller.text = filePath;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const DataSourceInput(),
        const SizedBox(
          width: 10,
        ),
        if (ref.watch(dataSourceProvider) == DataSources.excel) ...[
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
                labelText: "ملف الاكسيل",
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
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
              backgroundColor: Colors.blue.shade600,
              foregroundColor: Colors.blue.shade50,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            label: const Text(
              "تصفح",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ],
    );
  }
}
