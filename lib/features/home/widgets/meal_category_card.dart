import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/widgets/category_icon.dart';
import 'package:mealflow/features/home/widgets/meal_chip.dart';
import 'package:provider/provider.dart';

class MealCategoryCard extends StatelessWidget {
  final MealCategory category;
  final List<Meal> meals;
  final IconData icon;
  final Color iconColor;
  const MealCategoryCard({
    super.key,
    required this.category,
    required this.meals,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final completed =
        meals.isNotEmpty && meals.every((meal) => meal.isCompleted);

    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.medium,
        boxShadow: AppShadows.small,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CategoryIcon(icon: icon, iconColor: iconColor),

          AppSpacing.horizontalMD,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.displayName,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              AppSpacing.verticalSM,

              meals.isEmpty
                  ? const Text('No meals added yet.')
                  : Wrap(
                      spacing: 8,
                      direction: Axis.vertical,
                      children: meals
                          .map((meal) => MealChip(meal: meal))
                          .toList(),
                    ),
            ],
          ),

          const Spacer(),

          Checkbox(
            value: completed,
            onChanged: (_) {
              context.read<MealProvider>().toggleMealCategory(category);
            },
          ),
        ],
      ),
    );
  }
}
