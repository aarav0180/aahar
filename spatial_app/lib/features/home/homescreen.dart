import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:spatial_app/common/translation/locale_keys.g.dart';
import '../../common/widgets/Button/action_button.dart';
import '../../core/theme/app_theme.dart';
import '../../common/widgets/Header/header.dart';
import '../../common/utils/constants.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with translated name
              // Text(
              //   Constants.userName, // Display user name
              //   style: context.textTheme.displaySmall!.copyWith(
              //     color: context.whiteColor,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 32,
              //   ),
              // ),
              const SizedBox(height: 40),

              // Staggered Grid Animation
              AnimationLimiter(
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(4, (index) {
                    final labels = [
                      'send'.tr(),      // Using translation keys
                      'receive'.tr(),
                      'files'.tr(),
                      'settings'.tr()
                    ];

                    final icons = [
                      Icons.send_rounded,
                      Icons.download_rounded,
                      Icons.folder_rounded,
                      Icons.settings_rounded
                    ];

                    final colors = [
                      context.primaryColor,
                      context.secondaryColor,
                      context.secondaryLight,
                      context.darkGreyColor,
                    ];

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      columnCount: 2,
                      child: ScaleAnimation(
                        scale: 0.85,
                        child: FadeInAnimation(
                          child: MouseRegion(
                            onEnter: (_) => setState(() {}),
                            onExit: (_) => setState(() {}),
                            child: ActionButton(
                              label: labels[index],
                              icon: icons[index],
                              color: colors[index],
                              onTap: () {
                                // Handle button actions
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


