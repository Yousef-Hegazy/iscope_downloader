import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/presentation/providers/providers.dart';

class DownloadButton extends ConsumerWidget {
  const DownloadButton({
    super.key,
  });

  void _handleDownloadClick(BuildContext context, WidgetRef ref) async {
    try {
      final filePath = ref.watch(fileProvider);

      if (filePath == null || filePath.isEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "برجاء اختيار ملف بالضغط على 'تصفح' قبل الضغط على تحميل",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            showCloseIcon: true,
            closeIconColor: Theme.of(context).colorScheme.onError,
          ),
        );
      } else {
        if (ref.watch(downloadAndCreateXmlProvider).loading) return;

        await ref
            .watch(downloadAndCreateXmlProvider.notifier)
            .downloadAndCreateXml();

        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog.adaptive(
                title: const Text("تم التحميل بنجاح 👍"),
                content: Text(
                    "تم تحميل الملفات في\n${Directory.current.path}\\downloads"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("تم"),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloading = ref.watch(downloadAndCreateXmlProvider).loading;

    return InkWell(
      onTap: downloading ? null : () => _handleDownloadClick(context, ref),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.teal.shade600,
          borderRadius: BorderRadius.circular(12),
          boxShadow: kElevationToShadow[4],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            downloading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(
                    height: 20,
                    width: 20,
                    child: Icon(
                      Icons.download_rounded,
                      size: 20,
                      color: Colors.white,
                    )),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "تحميل",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
