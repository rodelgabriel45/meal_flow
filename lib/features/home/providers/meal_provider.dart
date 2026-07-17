import 'package:flutter/material.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/services/meal_service.dart';

class MealProvider extends ChangeNotifier {
  final MealService _mealService = MealService();

  final List<Meal> _meals = [];
  List<Meal> get meals => List.unmodifiable(_meals);

  int get totalCalories {
    return _meals.fold(0, (sum, meal) => sum + meal.calories);
  }

  double get progress {
    if (_meals.isEmpty) return 0;

    final completed = _meals.where((meal) => meal.isCompleted).length;

    return completed / _meals.length;
  }

  MealProvider() {
    loadMeals();
  }

  Future<void> addMeal(Meal meal) async {
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

  Future<void> deleteMeal(String id) async {
    _meals.removeWhere((meal) => meal.id == id);

    await _mealService.saveMeals(meals);

    notifyListeners();
  }

  Future<void> updateMeal(Meal updatedMeal) async {
    final index = _meals.indexWhere((meal) => meal.id == updatedMeal.id);

    if (index == -1) return;

    _meals[index] = updatedMeal;

    await _mealService.saveMeals(_meals);

    notifyListeners();
  }

  Future<void> toggleMealCategory(MealCategory category) async {
    final categoryMeals = mealsByCategory(category);

    if (categoryMeals.isEmpty) return;

    final shouldComplete = categoryMeals.any((meal) => !meal.isCompleted);

    for (final meal in categoryMeals) {
      meal.isCompleted = shouldComplete;
    }

    await _mealService.saveMeals(_meals);

    notifyListeners();
  }

  Future<void> clearMeals() async {
    _meals.clear();

    await _mealService.clearMeals();

    notifyListeners();
  }

  List<Meal> mealsByCategory(MealCategory category) {
    return _meals.where((meal) => meal.category == category).toList();
  }
}
