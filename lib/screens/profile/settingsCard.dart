// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String setTitle;
  const SettingsCard({super.key, required this.setTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          setTitle,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Icon(Icons.keyboard_arrow_down, size: 32),
      ],
    );
  }
}
