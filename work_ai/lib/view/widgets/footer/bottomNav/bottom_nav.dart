import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:work_ai/view/screens/home_screen.dart';
import 'package:work_ai/view/screens/organization/organization.dart';
import 'package:work_ai/view/screens/search_ai/search_ai.dart';
import 'package:work_ai/view/screens/knowledge/knowledge_screen.dart';
import '../../../../core/utils/theme/app_colors.dart';
import 'bottom_nav_widget.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    OrganizationPage(),
    const SearchAi(),
    const KnowledgeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _currentIndex,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        showElevation: true,
        iconSize: 24,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        items: [
          FlashyTabBarItem(
            icon: const Icon(AntDesign.home_outline),
            title: const Text('Home'),
            activeColor: AppColors.primary,
            inactiveColor: AppColors.secondary,
          ),
          FlashyTabBarItem(
            icon: const Icon(AntDesign.cloud_server_outline),
            title: const Text('Organization'),
            activeColor: AppColors.primary,
            inactiveColor: AppColors.secondary,
          ),
          FlashyTabBarItem(
            icon: const Icon(AntDesign.search_outline),
            title: const Text('Search'),
            activeColor: AppColors.primary,
            inactiveColor: AppColors.secondary,
          ),
          FlashyTabBarItem(
            icon: const Icon(AntDesign.profile_outline),
            title: const Text('Profile'),
            activeColor: AppColors.primary,
            inactiveColor: AppColors.secondary,
          ),
        ],
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}