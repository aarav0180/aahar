import 'package:flutter/material.dart';

import '../../../../../core/configs/text_configs/text_config.dart';

class ListItem extends StatelessWidget {
  final String text;

  const ListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.blue[600], size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.small.copyWith(
                color: isDarkMode ? Colors.white60 : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}