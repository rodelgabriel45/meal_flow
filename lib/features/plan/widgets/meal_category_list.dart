import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/plan/widgets/meal_card.dart';

class MealCategoryList extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<Meal> meals;
  const MealCategoryList({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 18),
                AppSpacing.horizontalSM,
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),

            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          ],
        ),

        AppSpacing.verticalSM,

        if (meals.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'No Meals Planned.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          )
        else
          ...meals.map(
            (meal) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MealCard(meal: meal),
            ),
          ),
      ],
    );
  }
}
