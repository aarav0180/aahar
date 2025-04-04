import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(themeProvider.isDark ? Icons.dark_mode : Icons.light_mode),
      onPressed: () => themeProvider.toggleTheme(),
    );
  }
}
