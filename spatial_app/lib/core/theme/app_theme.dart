import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/utils/utils.dart';

class AppScrollBehavior extends ScrollBehavior {
  const AppScrollBehavior();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}

class NoTransitionsOnWeb extends PageTransitionsTheme {
  @override
  Widget buildTransitions<T>(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
      ) {
    if (Utils.isWeb) {
      return child;
    }
    return super.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

/// App Theme with black and white base + purplish secondary shades
class AppTheme {
  const AppTheme._();

  // Colors
  static const primaryColor = Color(0xFF000000); // Black
  static const secondaryColor = Color(0xFF7D3C98); // Purplish
  static const secondaryLight = Color(0xFF9B59B6); // Light Purple
  static const secondaryDark = Color(0xFF4A235A); // Dark Purple

  static const redColor = Color(0xFFD32F2F);
  static const greenColor = Color(0xFF4CAF50);
  static const charcoalColor = Color(0xFF333333);
  static const grayColor = Color(0xFF9E9E9E);
  static const darkGreyColor = Color(0xFF616161);
  static const whiteColor = Color(0xFFFFFFFF);
  static const transparentColor = Colors.transparent;

  // Border radius and opacity
  static const borderRadius = BorderRadius.all(Radius.circular(8));
  static const opacityEnabled = 1.0;
  static const opacityDisabled = 0.4;

  // System overlay
  static const systemOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: transparentColor,
    statusBarIconBrightness: Brightness.light, // For Android (light icons)
    statusBarBrightness: Brightness.dark, // For iOS (light icons)
  );

  /// Dark Theme with Google Fonts
  static final darkTheme = ThemeData(
    useMaterial3: false,
    pageTransitionsTheme: NoTransitionsOnWeb(),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryColor,
    cardColor: charcoalColor,
    cardTheme: const CardTheme(
      color: charcoalColor,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: grayColor),
    colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor).copyWith(
      surface: primaryColor,
      brightness: Brightness.dark,
      primary: secondaryColor,
      secondary: secondaryLight,
      onPrimary: whiteColor,
      onSecondary: whiteColor,
    ),

    // Google Fonts
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      displayLarge: GoogleFonts.roboto(
        color: whiteColor,
        fontWeight: FontWeight.w300,
        fontSize: 57,
      ),
      displayMedium: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 45,
      ),
      displaySmall: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 36,
      ),
      headlineLarge: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 28,
      ),
      headlineSmall: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 24,
      ),
      titleLarge: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 18,
      ),
      titleSmall: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 16,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 18,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 16,
      ),
      bodySmall: GoogleFonts.roboto(
        color: whiteColor,
        fontSize: 14,
      ),
      labelLarge: GoogleFonts.roboto(
        color: secondaryLight,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.roboto(
        color: secondaryColor,
        fontSize: 16,
      ),
      labelSmall: GoogleFonts.roboto(
        color: secondaryDark,
        fontSize: 14,
      ),
    ),

    appBarTheme: const AppBarTheme(
      systemOverlayStyle: systemOverlayStyle,
      elevation: 4,
      color: primaryColor,
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: whiteColor),
    ),
    dividerColor: grayColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        backgroundColor: secondaryColor,
        textStyle: const TextStyle(fontSize: 16, color: whiteColor),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        foregroundColor: secondaryLight,
        textStyle: const TextStyle(fontSize: 18, color: whiteColor),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryColor,
        side: const BorderSide(color: secondaryColor, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: const RoundedRectangleBorder(borderRadius: borderRadius),
        backgroundColor: transparentColor,
      ),
    ),
  );
}

extension ThemeExtension on BuildContext {
  // Text styles
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get displayLarge => textTheme.displayLarge!;
  TextStyle get displayMedium => textTheme.displayMedium!;
  TextStyle get displaySmall => textTheme.displaySmall!;

  TextStyle get headlineSmall => textTheme.headlineSmall!;
  TextStyle get headlineMedium => textTheme.headlineMedium!;
  TextStyle get headlineLarge => textTheme.headlineLarge!;

  TextStyle get bodyLarge => textTheme.bodyLarge!;
  TextStyle get bodyMedium => textTheme.bodyMedium!;
  TextStyle get bodySmall => textTheme.bodySmall!;

  TextStyle get labelLarge => textTheme.labelLarge!;
  TextStyle get labelMedium => textTheme.labelMedium!;
  TextStyle get labelSmall => textTheme.labelSmall!;

  TextStyle get titleLarge => textTheme.titleLarge!;
  TextStyle get titleMedium => textTheme.titleMedium!;
  TextStyle get titleSmall => textTheme.titleSmall!;

  // Colors
  Color get primaryColor => AppTheme.primaryColor;
  Color get secondaryColor => AppTheme.secondaryColor;
  Color get secondaryLight => AppTheme.secondaryLight;
  Color get secondaryDark => AppTheme.secondaryDark;
  Color get redColor => AppTheme.redColor;
  Color get greenColor => AppTheme.greenColor;
  Color get charcoalColor => AppTheme.charcoalColor;
  Color get grayColor => AppTheme.grayColor;
  Color get darkGreyColor => AppTheme.darkGreyColor;
  Color get whiteColor => AppTheme.whiteColor;
  Color get transparent => AppTheme.transparentColor;

  // Opacity
  double get opacityEnabled => AppTheme.opacityEnabled;
  double get opacityDisabled => AppTheme.opacityDisabled;
}
