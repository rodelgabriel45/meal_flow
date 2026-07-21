import 'package:mealflow/features/home/models/meal.dart';

class MealFormArgs {
  final Meal? meal;
  final MealCategory? category;
  final DateTime date;

  const MealFormArgs({this.meal, this.category, required this.date});
}
