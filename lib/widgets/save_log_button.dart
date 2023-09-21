import 'package:flutter/material.dart';

class SaveLogButton extends StatelessWidget {
  const SaveLogButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
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
      onPressed: onPressed,
      label: const Text(
        "حفظ السجل",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
