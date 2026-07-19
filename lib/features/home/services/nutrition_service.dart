import 'dart:convert';

import 'package:mealflow/features/home/models/nutrition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutritionService {
  static const _key = 'nutrition';

  Future<void> saveNutrition(Nutrition nutrition) async {
    final prefs = await SharedPreferences.getInstance();

    final nutritionJson = nutrition.toJson();

    final nutritionString = jsonEncode(nutritionJson);

    await prefs.setString(_key, nutritionString);
  }

  Future<Nutrition> loadNutrition() async {
    final prefs = await SharedPreferences.getInstance();

    final nutritionString = prefs.getString(_key);

    if (nutritionString == null) {
      return Nutrition.defaults;
    }

    try {
      final nutritionJson = jsonDecode(nutritionString);

      return Nutrition.fromJson(nutritionJson);
    } catch (e) {
      return Nutrition.defaults;
    }
  }

  Future<void> clearNutrition() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }

  Future<void> resetWater() async {
    final nutrition = await loadNutrition();

    final updatedNutrition = nutrition.copyWith(currentWater: 0);

    await saveNutrition(updatedNutrition);
  }
}
