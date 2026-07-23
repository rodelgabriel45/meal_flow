import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/plan/widgets/meal_card.dart';
import 'package:provider/provider.dart';

class FavoritePickerScreen extends StatelessWidget {
  const FavoritePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<MealProvider>().favoriteMeals();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Pick a Meal Template',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),

              AppSpacing.verticalLG,

              Expanded(
                child: ListView.separated(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index];

                    return MealCard(
                      meal: favorite,
                      onTap: () {
                        context.pop(favorite);
                      },
                    );
                  },
                  separatorBuilder: (_, _) {
                    return AppSpacing.verticalMD;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
