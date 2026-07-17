import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';

class NutritionStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onPressed;
  const NutritionStat({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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

        if (onPressed != null)
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Colors.white24,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 14, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
