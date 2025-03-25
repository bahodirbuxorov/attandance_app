import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  static Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false;
  }

  static Future<void> saveLocale(String languageCode, [String? countryCode]) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
    if (countryCode != null) {
      await prefs.setString('countryCode', countryCode);
    }
  }

  static Future<Locale?> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('languageCode');
    final country = prefs.getString('countryCode');
    if (lang == null) return null;
    return Locale(lang, country);
  }
}
