import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/widgets/category_icon.dart';

class MealCategoryCard extends StatelessWidget {
  final String category;
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
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.medium,
        boxShadow: AppShadows.small,
      ),
      child: Row(
        children: [
          CategoryIcon(icon: icon, iconColor: iconColor),

          AppSpacing.horizontalMD,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category, style: Theme.of(context).textTheme.titleMedium),

              AppSpacing.verticalSM,

              meals.isEmpty
                  ? const Text('No meals added yet.')
                  : Column(
                      children: meals.map((meal) => Text(meal.title)).toList(),
                    ),
            ],
          ),

          const Spacer(),

          Checkbox(
            value: false,
            onChanged: (value) {
              //
            },
          ),
        ],
      ),
    );
  }
}
