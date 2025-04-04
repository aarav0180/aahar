import 'package:flutter/material.dart';

abstract class AppLocales {

  AppLocales._();

  static const enIN = Locale('en', 'IN');

  static const hiIN = Locale('hi', 'IN');

  static const locales = [enIN, hiIN];
}
