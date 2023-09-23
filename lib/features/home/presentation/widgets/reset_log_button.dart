import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iscope_downloader/features/home/presentation/providers/log_provider.dart';

class ResetLogButton extends ConsumerWidget {
  const ResetLogButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: ref.read(logProvider.notifier).resetLog,
      style: IconButton.styleFrom(
        foregroundColor: Colors.red.shade50,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      icon: const Icon(Icons.delete_rounded),
      tooltip: "حذف السجل",
    );
  }
}
