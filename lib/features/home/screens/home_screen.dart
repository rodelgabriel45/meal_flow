import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/widgets/add_meal_button.dart';
import 'package:mealflow/features/home/widgets/meal_category_card.dart';
import 'package:mealflow/features/home/widgets/progress_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final meals = context.watch<MealProvider>().meals;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.menu), Icon(Icons.notifications_none)],
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
                          category: 'Breakfast',
                          meals: breakfasts,
                          icon: Icons.wb_sunny_outlined,
                          iconColor: AppColors.breakfast,
                        ),

                        AppSpacing.verticalSM,

                        MealCategoryCard(
                          category: 'Lunch',
                          meals: lunch,
                          icon: Icons.wb_sunny_outlined,
                          iconColor: AppColors.lunch,
                        ),

                        AppSpacing.verticalSM,

                        MealCategoryCard(
                          category: 'Breakfast',
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
