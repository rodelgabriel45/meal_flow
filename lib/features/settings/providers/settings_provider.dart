import 'package:flutter/material.dart';
import 'package:mealflow/features/settings/models/user.dart';
import 'package:mealflow/features/settings/services/settings_service.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsService _settingsService = SettingsService();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  User _user = const User.empty();

  User get user => _user;

  SettingsProvider() {
    loadTheme();
    loadUser();
  }

  Future<void> changeUserDetails({String? name, String? title}) async {
    _user = _user.copyWith(name: name, title: title);

    await _settingsService.saveUser(_user);

    notifyListeners();
  }

  Future<void> changeAvatar(String? imagePath) async {
    print("Image Path: $imagePath");

    _user = user.copyWith(imagePath: imagePath);

    await _settingsService.saveUser(_user);

    notifyListeners();
  }

  Future<void> loadUser() async {
    _user = await _settingsService.loadUser();

    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;

    await _settingsService.saveThemeMode(_themeMode);

    notifyListeners();
  }

  Future<void> loadTheme() async {
    _themeMode = await _settingsService.loadThemeMode();

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
