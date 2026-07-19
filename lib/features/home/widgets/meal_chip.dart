import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/router/widgets/meal_form_args.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class MealChip extends StatelessWidget {
  final Meal meal;
  const MealChip({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '/form',
          extra: MealFormArgs(meal: meal, date: meal.date),
        );
      },
      child: Chip(
        label: Column(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                meal.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  decoration: meal.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
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
