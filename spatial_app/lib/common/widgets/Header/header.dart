import 'package:flutter/material.dart';
import 'package:spatial_app/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../utils/constants.dart';
import '../../utils/app_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.primaryColor, context.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Logo Blur
          Positioned(
            right: -10,
            top: -03,
            child: Image.asset(
              AppAssets.PNG_BG_LOGO,
              height: 170,
              width: 170,
              color: Colors.white.withOpacity(0.2),
            ),
          ),

          // Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header Title & Subtitle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SPATIAL',  // Using localization
                        style: context.textTheme.headlineLarge!.copyWith(
                          color: context.whiteColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Seamless sharing, limitless freedom.',  // Subtext
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),

                  // App Logo with Shine Effect
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Glowing Effect
                      Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: context.secondaryColor.withOpacity(0.7),
                              blurRadius: 20,
                              spreadRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      // Logo
                      Image.asset(
                        AppAssets.PNG_BG_LOGO,
                        height: 90,
                        width: 90,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
