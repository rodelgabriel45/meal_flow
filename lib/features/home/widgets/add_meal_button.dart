import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/screens/meal_form_dialog.dart';

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealFormDialog(title: 'Add Meal'),
            ),
          );
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
