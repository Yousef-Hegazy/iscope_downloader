import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/providers/log_provider.dart';

class ProgressLog extends ConsumerWidget {
  const ProgressLog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = ref.watch(logProvider);

    return SizedBox(
      height: 200,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(12)),
          border: Border.all(
            width: 1,
            color: Colors.blue,
          ),
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: log.length,
          itemBuilder: (context, index) {
            final message = log[index];
            return Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SelectableText(
                message,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
              ),
            );
          },
        ),
      ),
    );
  }
}
