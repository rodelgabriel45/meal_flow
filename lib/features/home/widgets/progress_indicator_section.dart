import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_spacing.dart';

class ProgressIndicatorSection extends StatelessWidget {
  const ProgressIndicatorSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                  value: .75,
                  color: AppColors.surface,
                  strokeWidth: 8,
                ),
              ),

              Text(
                '75%',
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
