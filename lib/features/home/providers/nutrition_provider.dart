import 'package:flutter/material.dart';
import 'package:mealflow/features/home/models/nutrition.dart';
import 'package:mealflow/features/home/services/nutrition_service.dart';

class NutritionProvider extends ChangeNotifier {
  final NutritionService _nutritionService = NutritionService();

  Nutrition _nutrition = Nutrition.defaults;

  Nutrition get nutrition => _nutrition;

  NutritionProvider() {
    loadNutrition();
  }

  Future<void> updateTargets({
    required int calories,
    required int water,
  }) async {
    _nutrition = nutrition.copyWith(
      targetCalories: calories,
      targetWater: water,
    );

    await _nutritionService.saveNutrition(_nutrition);

    notifyListeners();
  }

  Future<void> drinkWater() async {
    _nutrition = _nutrition.copyWith(currentWater: _nutrition.currentWater + 1);

    await _nutritionService.saveNutrition(_nutrition);

    notifyListeners();
  }

  Future<void> loadNutrition() async {
    final loadedNutrition = await _nutritionService.loadNutrition();

    _nutrition = loadedNutrition;

    notifyListeners();
  }

  Future<void> resetWater() async {
    _nutrition = _nutrition.copyWith(currentWater: 0);

    await _nutritionService.saveNutrition(_nutrition);

    notifyListeners();
  }
}
