import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme/theme_provider.dart';


class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
            Provider.of<ThemeProvider>(context).isDark
                  ? 'assets/images/background/darkBg.png'
                  : 'assets/images/background/lightBg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
    );
  }
}