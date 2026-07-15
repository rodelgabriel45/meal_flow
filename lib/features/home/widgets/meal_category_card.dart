import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';

class MealCategoryCard extends StatelessWidget {
  final String category;
  final String meals;
  final IconData icon;
  final Color color;
  const MealCategoryCard({
    super.key,
    required this.category,
    required this.meals,
    required this.icon,
    required this.color,
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: AppRadius.medium,
              color: color,
            ),
            child: Icon(icon, size: 25),
          ),

          AppSpacing.horizontalMD,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category, style: Theme.of(context).textTheme.titleMedium),

              AppSpacing.verticalSM,

              Text(meals),
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
