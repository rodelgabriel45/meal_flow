import 'package:mealflow/features/home/models/meal.dart';

class MealFormArgs {
  final Meal? meal;
  final MealCategory? category;
  final DateTime date;
  final bool isEditing;

  const MealFormArgs({
    this.meal,
    this.category,
    required this.date,
    this.isEditing = false,
  });
}
