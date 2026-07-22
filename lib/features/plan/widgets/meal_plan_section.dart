import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/plan/widgets/meal_card.dart';
import 'package:mealflow/features/plan/widgets/meal_category_list.dart';
import 'package:provider/provider.dart';

class MealPlanSection extends StatelessWidget {
  final DateTime selectedDate;
  const MealPlanSection({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    Widget buildMealList(
      BuildContext context,
      MealProvider provider, {
      required bool favoritesOnly,
    }) {
      return ListView(
        children: [
          MealCategoryList(
            title: 'Breakfast',
            icon: Icons.wb_sunny_outlined,
            iconColor: AppColors.breakfast,
            date: selectedDate,
            category: MealCategory.breakfast,
            meals: provider.mealsByCategory(
              MealCategory.breakfast,
              selectedDate,
              favoritesOnly: favoritesOnly,
            ),
          ),
          MealCategoryList(
            title: 'Lunch',
            icon: Icons.wb_sunny_outlined,
            iconColor: AppColors.lunch,
            date: selectedDate,
            category: MealCategory.lunch,
            meals: provider.mealsByCategory(
              MealCategory.lunch,
              selectedDate,
              favoritesOnly: favoritesOnly,
            ),
          ),
          MealCategoryList(
            title: 'Dinner',
            icon: Icons.dark_mode_outlined,
            iconColor: AppColors.dinner,
            date: selectedDate,
            category: MealCategory.dinner,
            meals: provider.mealsByCategory(
              MealCategory.dinner,
              selectedDate,
              favoritesOnly: favoritesOnly,
            ),
          ),
          MealCategoryList(
            title: 'Snack',
            icon: Icons.apple,
            iconColor: AppColors.snack,
            date: selectedDate,
            category: MealCategory.snack,
            meals: provider.mealsByCategory(
              MealCategory.snack,
              selectedDate,
              favoritesOnly: favoritesOnly,
            ),
          ),
        ],
      );
    }

    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.medium,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,

                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadius.medium,
                ),

                indicatorSize: TabBarIndicatorSize.tab,

                labelColor: AppColors.surface,

                unselectedLabelColor: Colors.black54,

                tabs: const [
                  Tab(text: 'All Meals'),
                  Tab(text: 'Favorites'),
                ],
              ),
            ),

            AppSpacing.verticalMD,

            Expanded(
              child: TabBarView(
                children: [
                  // All Meals
                  MediaQuery.removePadding(
                    context: context,
                    child: Consumer<MealProvider>(
                      builder: (context, provider, child) {
                        return buildMealList(
                          context,
                          provider,
                          favoritesOnly: false,
                        );
                      },
                    ),
                  ),

                  // Favorites
                  MediaQuery.removePadding(
                    context: context,
                    child: Consumer<MealProvider>(
                      builder: (context, provider, child) {
                        final favorites = provider.favoriteMeals();

                        return favorites.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '⭐ No favorite meals yet.',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),

                                  AppSpacing.verticalMD,

                                  Text(
                                    'Tap "Save to Favorites" on a meal to see it here.',
                                  ),
                                ],
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return MealCard(meal: favorites[index]);
                                },
                                separatorBuilder: (_, _) =>
                                    AppSpacing.verticalSM,
                                itemCount: favorites.length,
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
