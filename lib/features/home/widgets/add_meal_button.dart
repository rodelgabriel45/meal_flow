import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/router/widgets/meal_form_args.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';

class AddMealButton extends StatelessWidget {
  const AddMealButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.medium),
        ),
        onPressed: () {
          context.push('/form', extra: MealFormArgs(date: DateTime.now()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColors.surface),

            AppSpacing.horizontalSM,

            Text(
              'Add Meal',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.surface),
            ),
          ],
        ),
      ),
    );
  }
}
