import 'package:flutter/material.dart';
import 'package:mealflow/app.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/providers/nutrition_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => NutritionProvider()),
      ],
      child: const MealFlow(),
    ),
  );
}
