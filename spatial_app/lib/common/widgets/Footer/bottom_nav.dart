import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:spatial_app/core/theme/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CrystalNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: context.secondaryColor,
      enableFloatingNavBar: true,
      enablePaddingAnimation: true,
      height: 70,
      borderRadius: 20,
      items: [
        CrystalNavigationBarItem(
          icon: Icons.home_rounded,
          unselectedIcon: Icons.home_outlined,
          selectedColor: context.primaryColor,
          unselectedColor: Colors.white60,
        ),
        CrystalNavigationBarItem(
          icon: Icons.people_alt,
          selectedColor: Colors.blueAccent,
          unselectedColor: Colors.white60,
        ),
        CrystalNavigationBarItem(
          icon: Icons.settings_rounded,
          selectedColor: Colors.orangeAccent,
          unselectedColor: Colors.white60,
        ),
      ],
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 400),
      // shadowColor: Colors.black.withOpacity(0.4),
    );
  }
}
