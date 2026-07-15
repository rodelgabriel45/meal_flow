import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/widgets/nutrition_stat.dart';
import 'package:mealflow/features/home/widgets/progress_indicator_section.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.large,
        color: AppColors.primary,
        boxShadow: AppShadows.medium,
      ),
      padding: AppSpacing.cardPadding,
      child: Row(
        children: [
          ProgressIndicatorSection(),

          AppSpacing.horizontalMD,

          Expanded(
            child: Column(
              children: [
                NutritionStat(
                  icon: Icons.local_fire_department_rounded,
                  label: 'Calories',
                  value: '1500/2000 kcal',
                ),

                AppSpacing.verticalSM,

                NutritionStat(
                  icon: Icons.water_drop_rounded,
                  label: 'Water',
                  value: '6/8 cups',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
