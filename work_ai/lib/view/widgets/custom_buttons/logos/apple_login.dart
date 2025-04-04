import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AppleLoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: SvgPicture.asset("assets/icons/apple.svg", height: 30),
      label: const Text("Continue with Apple"),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? Colors.blueGrey[900] : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isDarkMode ? Colors.white54 : Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
