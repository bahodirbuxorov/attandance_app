import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalizationConfig {
  static const supportedLocales = [
    Locale('uz', 'UZ'),
    Locale('uz', 'CY'), // Kirill
    Locale('ru', 'RU'),
    Locale('en', 'US'),
  ];

  static const fallbackLocale = Locale('uz', 'UZ');

  static const path = 'assets/translations';

  static Widget wrapWithLocalization(Widget app) {
    return EasyLocalization(
      supportedLocales: supportedLocales,
      fallbackLocale: fallbackLocale,
      path: path,
      child: app,
    );
  }
}
