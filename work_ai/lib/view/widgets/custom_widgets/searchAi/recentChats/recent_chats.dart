import 'package:flutter/material.dart';
import '../../../../../core/configs/text_configs/text_config.dart';
import '../../../../../core/utils/theme/app_colors.dart';
import 'build_chat.dart';

Widget buildRecentChats(BuildContext context) {
  List<String> chats = ["Enterprise Search SaaS MVP", "AI-driven Support Bots", "Cloud Infrastructure Costs"];
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Your recent chats", style: AppTextStyles.mediumBold.copyWith(color: isDarkMode ? AppColors.textDark : AppColors.textLight, fontSize: 20)),
            Text("View all >", style: AppTextStyles.small.copyWith(color: AppColors.primary)),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 10,
          runSpacing: 12,
          children: chats.take(4).map((chat) => chatCard(chat, context)).toList(),
        ),
      ],
    ),
  );
}