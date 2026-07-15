import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/widgets/add_meal_button.dart';
import 'package:mealflow/features/home/widgets/meal_category_card.dart';
import 'package:mealflow/features/home/widgets/progress_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

              MealCategoryCard(
                category: 'Breakfast',
                meals: 'Oatmeal with Berries',
                icon: Icons.wb_sunny_outlined,
                color: AppColors.breakfast,
              ),

              AppSpacing.verticalSM,

              MealCategoryCard(
                category: 'Lunch',
                meals: 'Grilled Chicken Salad',
                icon: Icons.wb_sunny_outlined,
                color: AppColors.lunch,
              ),

              AppSpacing.verticalSM,

              MealCategoryCard(
                category: 'Breakfast',
                meals: 'Salmon with Veggies',
                icon: Icons.dark_mode_outlined,
                color: AppColors.dinner,
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
