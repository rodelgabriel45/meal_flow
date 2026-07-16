import 'package:flutter/material.dart';
import 'package:mealflow/features/home/models/meal.dart';

class MealProvider extends ChangeNotifier {
  final List<Meal> _meals = [];
  List<Meal> get meals => List.unmodifiable(_meals);

  void saveMeal(Meal meal) {
    _meals.add(meal);

    notifyListeners();
  }

  List<Meal> mealsByCategory(MealCategory category) {
    return _meals.where((meal) => meal.category == category).toList();
  }
}
