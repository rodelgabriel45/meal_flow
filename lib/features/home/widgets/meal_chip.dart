import 'package:flutter/material.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/screens/meal_form_screen.dart';
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
          MaterialPageRoute(builder: (context) => MealFormScreen(meal: meal)),
        );
      },
      child: Chip(
        label: Column(
          children: [
            Text(
              meal.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                decoration: meal.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            Text(
              '${meal.calories} kcal',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: () {
          context.read<MealProvider>().deleteMeal(meal.id);
        },
      ),
    );
  }
}
