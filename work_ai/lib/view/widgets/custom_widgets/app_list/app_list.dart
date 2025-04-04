import 'dart:ui';
import 'package:flutter/material.dart';

class SlidingIconsList extends StatelessWidget {
  final List<Map<String, dynamic>> apps = [
    {"icon": Icons.calendar_today, "label": "Calendar"},
    {"icon": Icons.video_call, "label": "Meet"},
    {"icon": Icons.favorite, "label": "Health"},
    {"icon": Icons.mail, "label": "Gmail"},
    {"icon": Icons.cloud, "label": "Drive"},
    {"icon": Icons.dashboard, "label": "Dashboard"},
    {"icon": Icons.work, "label": "Work"},
  ];

  SlidingIconsList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 100, // Adjusted for better visibility
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print("Tapped on ${apps[index]['label']}");
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.blue[100]?.withOpacity(0.3)
                    : Colors.blue[100]?.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? Colors.blueAccent.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? Colors.blue[300]?.withOpacity(0.5)
                              : Colors.blue[700]?.withOpacity(0.7),
                        ),
                        child: Icon(
                          apps[index]["icon"],
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    apps[index]["label"],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
