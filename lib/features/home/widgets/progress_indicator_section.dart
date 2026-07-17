import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class ProgressIndicatorSection extends StatelessWidget {
  const ProgressIndicatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<MealProvider>().progress;

    return Expanded(
      child: Column(
        children: [
          Text(
            "Today's Progress",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.surface),
          ),

          AppSpacing.verticalSM,

          Stack(
            alignment: AlignmentGeometry.center,
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: CircularProgressIndicator(
                  value: progress,
                  color: AppColors.surface,
                  strokeWidth: 8,
                ),
              ),

              Text(
                '${(progress * 100).toInt()} %',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.surface),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
