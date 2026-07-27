import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mealflow/features/settings/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _themeKey = 'theme_mode';
  static const _userKey = 'user';

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_themeKey, mode.name);
  }

  Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_themeKey);

    if (value == null) {
      return ThemeMode.system;
    }

    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    final userJson = user.toJson();

    final userString = jsonEncode(userJson);

    await prefs.setString(_userKey, userString);
  }

  Future<User> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    final userString = prefs.getString(_userKey);

    if (userString == null) {
      return const User.empty();
    }

    final userJson = jsonDecode(userString);

    return User.fromJson(userJson);
  }
}
