import 'package:flutter/material.dart';
import 'package:work_ai/core/configs/text_configs/text_config.dart';
import 'header_row.dart';

import 'list_item.dart';

class SuggestionWidget extends StatefulWidget {
  const SuggestionWidget({super.key});

  @override
  State<SuggestionWidget> createState() => _SuggestionWidgetState();
}

class _SuggestionWidgetState extends State<SuggestionWidget> {
  bool showAll = false;

  void _toggle() {
    setState(() {
      showAll = !showAll;
    });
  }

  final List<String> suggestions = [
    "WORK AI 動画構成",
    "動画スクリプト",
    "Slack フィードバック",
    "営業トークスクリプト",
    "投資家向け提案叩き台"
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final displayedList = showAll ? suggestions : suggestions.take(3).toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: isDarkMode ? Colors.blueGrey[900] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderRow(),
              const SizedBox(height: 8),

              // List of Suggestions
              ...displayedList.map((item) => ListItem(text: item)),

              // Show More Button
              GestureDetector(
                onTap: _toggle,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    showAll ? "閉じる" : "更に見る……",
                    style: AppTextStyles.small.copyWith(
                      color: isDarkMode ? Colors.blueAccent : Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}