import 'package:flutter/material.dart';
import '../../../../core/configs/text_configs/text_config.dart';
import '../../../../core/utils/theme/app_colors.dart';

Widget searchChip(String text, BuildContext context, bool isDarkMode) {
  return Chip(
    label: Text(text, style: AppTextStyles.small.copyWith(color: isDarkMode ? AppColors.textDark : AppColors.textLight, fontSize: 12)),
    backgroundColor: Theme.of(context).cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}