import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_ai/core/utils/theme/app_colors.dart';
import '../../../core/configs/text_configs/text_config.dart';
import '../../../providers/theme/theme_provider.dart';

class HomeHeader extends StatefulWidget {
  final String title;
  final String upperTitle;
  final VoidCallback? onButtonPressed; // Optional button

  const HomeHeader({
    required this.title,
    required this.upperTitle,
    this.onButtonPressed,
    super.key,
  });

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Section (Titles & Bar)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.upperTitle,
                  style: AppTextStyles.small.copyWith(
                    color: isDarkMode ? Colors.blue[300] : Colors.blue[700],
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.title,
                  style: AppTextStyles.largeBold.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  height: 4,
                  width: 55,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.blue[300] : Colors.blue[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),

            // Right Section (Optional Button)
            if (widget.onButtonPressed != null)
              IconButton(
                icon: const Icon(Icons.menu, color: AppColors.primary),
                onPressed: widget.onButtonPressed,
                tooltip: "Open Drawer",
              ),
          ],
        ),
      ),
    );
  }
}


