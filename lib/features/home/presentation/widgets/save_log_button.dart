import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/presentation/providers/providers.dart';

class SaveLogButton extends ConsumerWidget {
  const SaveLogButton({super.key});

  void _saveLog(BuildContext context, WidgetRef ref) async {
    try {
      final log = ref.read(logProvider).join('\n');
      final directory = '${Directory.current.path}\\downloads';
      if (!await Directory(directory).exists()) {
        await Directory(directory).create();
      }
      final file = File('$directory\\download-log.txt');
      await file.writeAsString(log);

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text("تم الحفظ بنجاح 👍"),
            content: Text("تم حفظ سجل العمليات في\n${file.path}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("تم"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logEmpty = ref.watch(logProvider).isEmpty;

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      icon: const Icon(Icons.save_rounded),
      onPressed: logEmpty ? null : () => _saveLog(context, ref),
      label: const Text(
        "حفظ السجل",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
