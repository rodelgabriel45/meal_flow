import 'package:flutter/material.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/services/meal_service.dart';

class MealProvider extends ChangeNotifier {
  final MealService _mealService = MealService();
  final List<Meal> _meals = [];
  List<Meal> get meals => List.unmodifiable(_meals);

  MealProvider() {
    loadMeals();
  }

  Future<void> saveMeal(Meal meal) async {
    _meals.add(meal);

    await _mealService.saveMeals(_meals);

    notifyListeners();
  }

  Future<void> loadMeals() async {
    final loadedMeals = await _mealService.loadMeals();

    _meals
      ..clear()
      ..addAll(loadedMeals);

    notifyListeners();
  }

  Future<void> deleteMeal(Meal meal) async {
    _meals.remove(meal);

    await _mealService.saveMeals(meals);

    notifyListeners();
  }

  List<Meal> mealsByCategory(MealCategory category) {
    return _meals.where((meal) => meal.category == category).toList();
  }
}
