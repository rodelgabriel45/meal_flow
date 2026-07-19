import 'package:mealflow/features/home/models/meal.dart';

class MealFormArgs {
  final Meal? meal;
  final DateTime date;

  const MealFormArgs({this.meal, required this.date});
}
