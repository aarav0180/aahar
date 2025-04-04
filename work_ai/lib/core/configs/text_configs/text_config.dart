import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/theme/app_colors.dart';

class AppTextStyles {
  // Large Text Styles
  static TextStyle large = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
  );

  static TextStyle largeBold = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  // Medium Text Styles
  static TextStyle medium = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
  );

  static TextStyle mediumBold = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  // Small Text Styles
  static TextStyle small = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primary,
  );

  static TextStyle smallBold = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  // Header & Body Styles
  static const TextStyle headerStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.secondary,
  );

  static const TextStyle bodyBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );

  // Caption Text Style
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.secondary,
  );

  static const TextStyle captionBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.secondary,
  );
}
