import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final int height;
  const LogoWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logo",
      child: Image.asset("assets/images/app_logo/logo.png", height: height.toDouble()),
    );
  }
}
