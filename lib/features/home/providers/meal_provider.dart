import 'package:flutter/material.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/services/app_service.dart';
import 'package:mealflow/features/home/services/meal_service.dart';
import 'package:mealflow/features/home/services/nutrition_service.dart';

class MealProvider extends ChangeNotifier {
  final MealService _mealService = MealService();
  final NutritionService _nutritionService = NutritionService();
  final AppService _appService = AppService();

  final List<Meal> _meals = [];
  List<Meal> get meals => List.unmodifiable(_meals);

  int get totalCalories {
    final todayMeals = _meals.where(
      (meal) => isSameDay(meal.date, DateTime.now()),
    );

    return todayMeals.fold(0, (sum, meal) => sum + meal.calories);
  }

  double get progress {
    final todayMeals = _meals.where(
      (meal) => isSameDay(meal.date, DateTime.now()),
    );

    if (todayMeals.isEmpty) return 0;

    final completed = todayMeals.where((meal) => meal.isCompleted).length;

    return completed / todayMeals.length;
  }

  MealProvider() {
    loadMeals();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
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

    await checkForNewDay();

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

  Future<void> toggleMealCategory(MealCategory category, DateTime date) async {
    final categoryMeals = mealsByCategory(category, date);

    if (categoryMeals.isEmpty) return;

    final shouldComplete = categoryMeals.any((meal) => !meal.isCompleted);

    for (var i = 0; i < _meals.length; i++) {
      if (_meals[i].category == category && isSameDay(_meals[i].date, date)) {
        _meals[i] = _meals[i].copyWith(isCompleted: shouldComplete);
      }
    }

    await _mealService.saveMeals(_meals);

    notifyListeners();
  }

  Future<void> clearMeals() async {
    _meals.clear();

    await _mealService.clearMeals();

    notifyListeners();
  }

  Future<void> checkForNewDay() async {
    final lastOpened = await _appService.loadLastOpeneddate();

    final today = DateTime.now();

    if (lastOpened == null) {
      await _appService.saveLastOpenedDate(today);
      return;
    }

    final isNewDay = !isSameDay(lastOpened, today);

    if (!isNewDay) return;

    await _nutritionService.resetWater();

    await _appService.saveLastOpenedDate(today);
  }

  List<Meal> mealsByCategory(MealCategory category, DateTime date) {
    return _meals.where((meal) {
      return meal.category == category && isSameDay(meal.date, date);
    }).toList();
  }
}
