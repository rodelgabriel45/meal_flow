import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';

class NutritionStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const NutritionStat({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: AppRadius.medium,
          ),
          child: Icon(icon, size: 18, color: AppColors.surface),
        ),

        AppSpacing.horizontalSM,

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: AppColors.surface),
            ),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.surface),
            ),
          ],
        ),
      ],
    );
  }
}
