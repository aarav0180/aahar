import 'package:flutter/material.dart';
import 'package:work_ai/core/configs/text_configs/text_config.dart';

Widget buildTab({bool isActive = false, bool hasBadge = false, required String label, required BuildContext context}) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Text(
          label,
          style: AppTextStyles.smallBold.copyWith(
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.blue[700] : isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        if (hasBadge)
          Container(
            margin: const EdgeInsets.only(left: 6),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "5",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
      ],
    ),
  );
}
