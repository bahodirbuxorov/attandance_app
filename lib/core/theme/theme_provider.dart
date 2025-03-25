import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/shared_prefs.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  void _loadTheme() async {
    state = await SharedPrefs.loadTheme();
  }

  void toggleTheme() {
    state = !state;
    SharedPrefs.saveTheme(state);
  }
}
