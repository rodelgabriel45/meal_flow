import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/screens/meal_form_dialog.dart';
import 'package:provider/provider.dart';

class MealChip extends StatelessWidget {
  final Meal meal;
  const MealChip({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MealFormDialog(title: 'Edit Meal', meal: meal),
          ),
        );
      },
      child: Chip(
        label: Row(
          children: [
            Text(meal.title),
            AppSpacing.horizontalXS,
            Text(
              '${meal.calories} kcal',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: () {
          context.read<MealProvider>().deleteMeal(meal);
        },
      ),
    );
  }
}
