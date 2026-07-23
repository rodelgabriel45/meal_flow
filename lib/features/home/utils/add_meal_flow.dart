import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/router/widgets/meal_form_args.dart';
import 'package:mealflow/features/home/models/meal.dart';

Future<void> startAddMealFlow(
  BuildContext context, {
  required DateTime date,
  MealCategory? category,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'How would you like to add a meal?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.add),
              title: const Text('Create New Meal'),
              onTap: () {
                context.pop();

                context.push(
                  '/form',
                  extra: MealFormArgs(date: DateTime.now(), category: category),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.star, color: Colors.amberAccent),
              title: const Text('Choose From Favorites'),
              onTap: () async {
                final Meal? favoriteMeal = await context.push<Meal>(
                  '/favorite-picker',
                );

                if (favoriteMeal != null) {
                  if (!context.mounted) return;
                  context.pop();

                  context.push(
                    '/form',
                    extra: MealFormArgs(
                      date: DateTime.now(),
                      meal: favoriteMeal,
                      isEditing: false,
                      category: category,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
