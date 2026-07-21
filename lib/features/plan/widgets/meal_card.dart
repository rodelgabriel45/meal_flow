import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/router/widgets/meal_form_args.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/plan/widgets/meal_image.dart';
import 'package:provider/provider.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.push(
            '/form',
            extra: MealFormArgs(date: meal.date, meal: meal),
          );
        },
        borderRadius: AppRadius.large,
        child: Ink(
          padding: AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.large,
            boxShadow: AppShadows.small,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: ClipRRect(
                  borderRadius: AppRadius.medium,
                  child: MealImage(),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: AppSpacing.cardPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),

                      AppSpacing.verticalSM,

                      Text(
                        '${meal.calories} kcal',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () async {
                    final shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Meal'),
                          content: const Text(
                            'Are you sure you want to delete this meal?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop(false);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop(true);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );

                    if (shouldDelete == true) {
                      if (!context.mounted) return;

                      context.read<MealProvider>().deleteMeal(meal.id);
                    }
                  },
                  icon: Icon(Icons.delete_outline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
