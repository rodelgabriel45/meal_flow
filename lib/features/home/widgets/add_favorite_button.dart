import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class AddFavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;
  const AddFavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 56,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.surface,
            ),
            onPressed: onPressed,
            child: Text(isFavorite ? 'Saved' : 'Save to favorites'),
          ),
        );
      },
    );
  }
}
