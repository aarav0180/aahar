import 'package:flutter/material.dart';
import '../../../../core/utils/theme/app_colors.dart';

class NewChatButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NewChatButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        width: 64,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 24,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
