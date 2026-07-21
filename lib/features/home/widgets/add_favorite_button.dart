import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class AddFavoriteButton extends StatelessWidget {
  final String mealId;
  const AddFavoriteButton({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (context, provider, child) {
        final currentMeal = provider.meals.firstWhere((m) => m.id == mealId);

        return SizedBox(
          height: 56,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.surface,
            ),
            onPressed: () {
              provider.toggleFavorite(currentMeal);
            },
            child: Text(currentMeal.isFavorite ? 'Saved' : 'Save to favorites'),
          ),
        );
      },
    );
  }
}
