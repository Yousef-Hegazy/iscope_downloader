import 'package:flutter/material.dart';

class LogoRow extends StatelessWidget {
  const LogoRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/i-Scope_portal.png',
          width: 250,
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Image.asset(
            'assets/images/excel_logo.png',
            width: 35,
          ),
        ),
      ],
    );
  }
}
