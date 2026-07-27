import 'package:flutter/material.dart';
import 'package:mealflow/features/home/widgets/edit_nutrition_dialog.dart';

void showEditNutritionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const EditNutritionDialog(),
  );
}
