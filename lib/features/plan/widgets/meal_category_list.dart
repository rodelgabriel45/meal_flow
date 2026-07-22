import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/router/widgets/meal_form_args.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/plan/widgets/meal_card.dart';

class MealCategoryList extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final DateTime date;
  final MealCategory category;
  final List<Meal> meals;
  const MealCategoryList({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.date,
    required this.category,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildAnimatedMeal(Animation<double> animation, Meal meal) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, .08),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MealCard(key: ValueKey(meal.id), meal: meal),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 18),
                AppSpacing.horizontalSM,
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),

            IconButton(
              onPressed: () {
                context.push(
                  '/form',
                  extra: MealFormArgs(date: date, category: category),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        AppSpacing.verticalSM,

        if (meals.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'No Meals Planned.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          )
        else
          ImplicitlyAnimatedList<Meal>(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            items: meals,
            areItemsTheSame: (oldItem, newItem) {
              return oldItem.id == newItem.id;
            },

            itemBuilder: (context, animation, meal, i) =>
                buildAnimatedMeal(animation, meal),
            removeItemBuilder: (context, animation, meal) =>
                buildAnimatedMeal(animation, meal),
          ),
      ],
    );
  }
}
