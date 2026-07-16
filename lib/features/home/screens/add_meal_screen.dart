import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/widgets/category_icon.dart';
import 'package:provider/provider.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mealNameController = TextEditingController();
  final _caloriesController = TextEditingController();

  MealCategory _selectedCategory = MealCategory.breakfast;

  @override
  void dispose() {
    _mealNameController.dispose();
    _caloriesController.dispose();

    super.dispose();
  }

  void _addMeal() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<MealProvider>().saveMeal(
      Meal(
        title: _mealNameController.text.trim(),
        calories: int.parse(_caloriesController.text),
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),

                  Text(
                    'Add Meal',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  IconButton(
                    onPressed: () {
                      _addMeal();
                    },
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),

              AppSpacing.verticalMD,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: AppRadius.large,
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCategory = MealCategory.breakfast;
                          });
                        },
                        child: CategoryIcon(
                          icon: _selectedCategory == MealCategory.breakfast
                              ? Icons.wb_sunny
                              : Icons.wb_sunny_outlined,
                          iconColor: AppColors.breakfast,
                        ),
                      ),

                      AppSpacing.verticalSM,

                      Text(
                        'Breakfast',
                        style: _selectedCategory == MealCategory.breakfast
                            ? Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              )
                            : null,
                      ),
                    ],
                  ),

                  AppSpacing.horizontalLG,

                  Column(
                    children: [
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: AppRadius.large,
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCategory = MealCategory.lunch;
                          });
                        },
                        child: CategoryIcon(
                          icon: _selectedCategory == MealCategory.lunch
                              ? Icons.wb_sunny
                              : Icons.wb_sunny_outlined,
                          iconColor: AppColors.lunch,
                        ),
                      ),

                      AppSpacing.verticalSM,

                      Text(
                        'Lunch',
                        style: _selectedCategory == MealCategory.lunch
                            ? Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              )
                            : null,
                      ),
                    ],
                  ),

                  AppSpacing.horizontalLG,

                  Column(
                    children: [
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: AppRadius.large,
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCategory = MealCategory.dinner;
                          });
                        },
                        child: CategoryIcon(
                          icon: _selectedCategory == MealCategory.dinner
                              ? Icons.dark_mode
                              : Icons.dark_mode_outlined,
                          iconColor: AppColors.dinner,
                        ),
                      ),

                      AppSpacing.verticalSM,

                      Text(
                        'Dinner',
                        style: _selectedCategory == MealCategory.dinner
                            ? Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              )
                            : null,
                      ),
                    ],
                  ),
                ],
              ),

              AppSpacing.verticalLG,

              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meal Name',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      AppSpacing.verticalSM,
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a meal name';
                          }
                          return null;
                        },
                        controller: _mealNameController,
                        decoration: InputDecoration(
                          hintText: 'e.g Avocado Toast',
                        ),
                        textInputAction: TextInputAction.next,
                      ),

                      AppSpacing.verticalMD,

                      Text(
                        'Calories (kcal)',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      AppSpacing.verticalSM,
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter meal calories';
                          }

                          final calories = int.tryParse(value);

                          if (calories == null) {
                            return 'Calories must be a number';
                          }

                          if (calories <= 0) {
                            return 'Calories must be greater than 0';
                          }

                          return null;
                        },
                        controller: _caloriesController,
                        decoration: InputDecoration(hintText: 'kcal'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
