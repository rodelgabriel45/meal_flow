import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/plan/widgets/meal_category_list.dart';
import 'package:provider/provider.dart';

class MealPlanSection extends StatelessWidget {
  final DateTime selectedDate;
  const MealPlanSection({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
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
                  MediaQuery.removePadding(
                    context: context,
                    child: Consumer<MealProvider>(
                      builder: (context, provider, child) {
                        final breakfasts = provider.mealsByCategory(
                          MealCategory.breakfast,
                          selectedDate,
                        );
                        final lunches = provider.mealsByCategory(
                          MealCategory.lunch,
                          selectedDate,
                        );
                        final dinners = provider.mealsByCategory(
                          MealCategory.dinner,
                          selectedDate,
                        );
                        final snacks = provider.mealsByCategory(
                          MealCategory.snack,
                          selectedDate,
                        );

                        return ListView(
                          children: [
                            MealCategoryList(
                              title: 'Breakfast',
                              icon: Icons.wb_sunny_outlined,
                              iconColor: AppColors.breakfast,
                              meals: breakfasts,
                            ),
                            MealCategoryList(
                              title: 'Lunch',
                              icon: Icons.wb_sunny_outlined,
                              iconColor: AppColors.lunch,
                              meals: lunches,
                            ),
                            MealCategoryList(
                              title: 'Dinner',
                              icon: Icons.dark_mode_outlined,
                              iconColor: AppColors.dinner,
                              meals: dinners,
                            ),
                            MealCategoryList(
                              title: 'Snack',
                              icon: Icons.apple,
                              iconColor: AppColors.snack,
                              meals: snacks,
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  MediaQuery.removePadding(
                    context: context,
                    child: Consumer<MealProvider>(
                      builder: (context, provider, child) {
                        final breakfasts = provider.mealsByCategory(
                          MealCategory.breakfast,
                          selectedDate,
                        );
                        final lunches = provider.mealsByCategory(
                          MealCategory.lunch,
                          selectedDate,
                        );
                        final dinners = provider.mealsByCategory(
                          MealCategory.dinner,
                          selectedDate,
                        );
                        final snacks = provider.mealsByCategory(
                          MealCategory.snack,
                          selectedDate,
                        );

                        return ListView(
                          children: [
                            MealCategoryList(
                              title: 'Breakfast',
                              icon: Icons.wb_sunny_outlined,
                              iconColor: AppColors.breakfast,
                              meals: breakfasts,
                            ),
                            MealCategoryList(
                              title: 'Lunch',
                              icon: Icons.wb_sunny_outlined,
                              iconColor: AppColors.lunch,
                              meals: lunches,
                            ),
                            MealCategoryList(
                              title: 'Dinner',
                              icon: Icons.dark_mode_outlined,
                              iconColor: AppColors.dinner,
                              meals: dinners,
                            ),
                            MealCategoryList(
                              title: 'Snack',
                              icon: Icons.apple,
                              iconColor: AppColors.snack,
                              meals: snacks,
                            ),
                          ],
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
