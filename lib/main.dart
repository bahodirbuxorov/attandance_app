import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'app.dart';
import 'core/localization/localization_setup.dart';
import 'core/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final savedLocale = await SharedPrefs.loadLocale();

  runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('uz', 'UZ'),
          Locale('uz', 'CY'),
          Locale('ru', 'RU'),
          Locale('en', 'US'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('uz', 'UZ'),
        startLocale: savedLocale ?? const Locale('uz', 'UZ'),
        child: const ProviderScope(child: MyApp()),
      )

  );
}
