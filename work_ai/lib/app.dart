import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_ai/providers/theme/theme_provider.dart';
import 'package:work_ai/routes/auth/auth_wrapper.dart';
import 'core/utils/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: const AuthWrapper(), // Checks if user is logged in
    );
  }
}
