import 'package:flutter/material.dart';
import 'package:work_ai/view/widgets/custom_widgets/home/meeting/meeting_card.dart';

class VideoCallList extends StatefulWidget {
  const VideoCallList({super.key});

  @override
  _VideoCallListState createState() => _VideoCallListState();
}

class _VideoCallListState extends State<VideoCallList> {
  bool isAnyExpanded = false;

  void toggleExpand(bool expanded) {
    setState(() {
      isAnyExpanded = expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      duration: const Duration(milliseconds: 300),
      height: isAnyExpanded ? 210 : 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4, // Example count
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MeetingCard(onToggle: toggleExpand),
          );
        },
      ),
    );
  }
}
