import 'dart:convert';

import 'package:mealflow/features/home/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MealService {
  static const _key = 'meals';

  Future<void> saveMeals(List<Meal> meals) async {
    final prefs = await SharedPreferences.getInstance();

    final mealsJSon = meals.map((meal) => meal.toJson()).toList();

    final mealsString = jsonEncode(mealsJSon);

    await prefs.setString(_key, mealsString);
  }

  Future<List<Meal>> loadMeals() async {
    final prefs = await SharedPreferences.getInstance();

    final mealsString = prefs.getString(_key);

    if (mealsString == null) {
      return [];
    }

    final mealsJson = jsonDecode(mealsString);

    return (mealsJson as List).map((json) => Meal.fromJson(json)).toList();
  }

  Future<void> clearMeals() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }
}
