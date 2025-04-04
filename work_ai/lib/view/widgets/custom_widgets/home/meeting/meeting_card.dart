import 'package:flutter/material.dart';
import '../../../../../core/configs/text_configs/text_config.dart';
import '../../../../../core/utils/theme/app_colors.dart';

class MeetingCard extends StatefulWidget {
  final Function(bool) onToggle;
  const MeetingCard({super.key, required this.onToggle});


  @override
  _MeetingCardState createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
    widget.onToggle(isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleExpand,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: isExpanded
            ? MediaQuery.of(context).size.width * 0.66
            : MediaQuery.of(context).size.width * 0.48,
        height: isExpanded ? 200 : 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "今日",
              style: AppTextStyles.smallBold.copyWith(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "今・10:00 - 11:00",
              style: AppTextStyles.small.copyWith(color: AppColors.secondary),
            ),
            const SizedBox(height: 4),
            Text(
              "お打ち合わせ/Work AI",
              style: AppTextStyles.smallBold.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),

            if (isExpanded) ...[
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                opacity: isExpanded ? 1.0 : 0.0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  offset: isExpanded ? Offset.zero : const Offset(0, -0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          // CircleAvatar(radius: 12, backgroundColor: Colors.grey[300]),
                          // const SizedBox(width: 4),
                          // CircleAvatar(radius: 12, backgroundColor: Colors.grey[400]),
                          // const SizedBox(width: 4),
                          // CircleAvatar(radius: 12, backgroundColor: Colors.grey[500]),
                          // const SizedBox(width: 6),
                          Text("Toru Tano and 他2人", style: AppTextStyles.small),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.video_call, size: 16, color: Colors.white),
                        label: Text("参加する", style: AppTextStyles.small.copyWith(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text("Zoom: WORK AI MTG", style: AppTextStyles.small),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
