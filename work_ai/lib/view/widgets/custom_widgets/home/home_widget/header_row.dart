import 'package:flutter/material.dart';
import 'tab_widget.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        buildTab(label: "提案", isActive: true, context: context),
        buildTab(label: "最近", context: context),
        buildTab(label: "通知", hasBadge: true, context: context),
        const Spacer(),
        Icon(Icons.more_vert, color: isDarkMode ? Colors.white70 : Colors.black54),
      ],
    );
  }
}