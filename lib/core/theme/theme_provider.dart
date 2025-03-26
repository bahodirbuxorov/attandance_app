import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/shared_prefs.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(true) {
    _loadTheme();
  }

  void _loadTheme() async {
    final savedTheme = await SharedPrefs.loadTheme();
    state = savedTheme ?? true;
  }

  void toggleTheme() {
    state = !state;
    SharedPrefs.saveTheme(state);
  }
}
