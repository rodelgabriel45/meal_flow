import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/providers/nutrition_provider.dart';
import 'package:mealflow/features/home/widgets/add_meal_button.dart';
import 'package:mealflow/features/home/widgets/edit_nutrition_dialog.dart';
import 'package:mealflow/features/home/widgets/meal_category_card.dart';
import 'package:mealflow/features/home/widgets/progress_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showEditNutritionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const EditNutritionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      showEditNutritionDialog(context);
                    },
                    icon: Icon(Icons.mode_edit),
                  ),
                  InkWell(
                    onTap: () async {
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Clear Today's Progress"),
                            content: const Text(
                              "Are you sure you want to clear today's progress?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text('Cancel'),
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );

                      if (shouldDelete == true) {
                        if (!context.mounted) return;

                        context.read<MealProvider>().clearMeals();
                        context.read<NutritionProvider>().resetWater();
                      }
                    },
                    child: Row(
                      children: [
                        Text('Clear Progress'),
                        AppSpacing.horizontalSM,
                        Icon(Icons.delete_forever),
                      ],
                    ),
                  ),
                ],
              ),

              AppSpacing.verticalLG,

              Text(
                'Good morning, Rod',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              AppSpacing.verticalSM,

              Text("Let's plan your meals for today."),

              AppSpacing.verticalMD,

              ProgressCard(),

              AppSpacing.verticalMD,

              Text(
                "Today's Meals",
                style: Theme.of(context).textTheme.titleMedium,
              ),

              AppSpacing.verticalMD,

              Expanded(
                child: Consumer<MealProvider>(
                  builder: (context, provider, child) {
                    final breakfasts = provider.mealsByCategory(
                      MealCategory.breakfast,
                    );
                    final lunch = provider.mealsByCategory(MealCategory.lunch);
                    final dinner = provider.mealsByCategory(
                      MealCategory.dinner,
                    );

                    return ListView(
                      children: [
                        MealCategoryCard(
                          category: MealCategory.breakfast,
                          meals: breakfasts,
                          icon: Icons.wb_sunny_outlined,
                          iconColor: AppColors.breakfast,
                        ),

                        AppSpacing.verticalSM,

                        MealCategoryCard(
                          category: MealCategory.lunch,
                          meals: lunch,
                          icon: Icons.wb_sunny_outlined,
                          iconColor: AppColors.lunch,
                        ),

                        AppSpacing.verticalSM,

                        MealCategoryCard(
                          category: MealCategory.dinner,
                          meals: dinner,
                          icon: Icons.dark_mode_outlined,
                          iconColor: AppColors.dinner,
                        ),
                      ],
                    );
                  },
                ),
              ),

              AppSpacing.verticalMD,

              AddMealButton(),
            ],
          ),
        ),
      ),
    );
  }
}
