import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void changeTheme(ThemeMode mode) {
    if (_themeMode == mode) return;

    _themeMode = mode;

    notifyListeners();
  }

  String get themeName {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';

      case ThemeMode.dark:
        return 'Dark';

      case ThemeMode.system:
        return 'System Default';
    }
  }
}
