import 'package:flutter/material.dart';
import 'package:mealflow/app.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => MealProvider(), child: MealFlow()),
  );
}
