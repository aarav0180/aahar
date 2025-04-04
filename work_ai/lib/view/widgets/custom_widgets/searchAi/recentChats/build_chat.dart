import 'package:flutter/material.dart';

import '../../../../../core/configs/text_configs/text_config.dart';
import '../../../../../core/utils/theme/app_colors.dart';

Widget chatCard(String title, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.435,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.chat_bubble_outline, color: AppColors.primary),
        const SizedBox(height: 6),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.small.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text("3 messages", style: AppTextStyles.small.copyWith(color: AppColors.secondary)),
      ],
    ),
  );
}