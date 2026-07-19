import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/core/validators/app_validators.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/widgets/category_icon.dart';
import 'package:provider/provider.dart';

class MealFormScreen extends StatefulWidget {
  final Meal? meal;
  final DateTime date;
  const MealFormScreen({super.key, this.meal, required this.date});

  @override
  State<MealFormScreen> createState() => _MealFormScreenState();
}

class _MealFormScreenState extends State<MealFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _mealNameController;
  late TextEditingController _caloriesController;

  late MealCategory _selectedCategory;

  @override
  void initState() {
    super.initState();

    _selectedCategory = widget.meal?.category ?? MealCategory.breakfast;
    _mealNameController = TextEditingController(text: widget.meal?.title ?? '');
    _caloriesController = TextEditingController(
      text: widget.meal?.calories.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _mealNameController.dispose();
    _caloriesController.dispose();

    super.dispose();
  }

  void _addMeal() {
    context.read<MealProvider>().addMeal(
      Meal(
        title: _mealNameController.text.trim(),
        calories: int.parse(_caloriesController.text),
        category: _selectedCategory,
        date: widget.date,
      ),
    );

    context.pop();
  }

  void _updateMeal() {
    final updatedMeal = widget.meal!.copyWith(
      title: _mealNameController.text.trim(),
      calories: int.parse(_caloriesController.text),
      category: _selectedCategory,
    );

    context.read<MealProvider>().updateMeal(updatedMeal);

    context.pop();
  }

  void _saveMeal() {
    if (!_formKey.currentState!.validate()) return;

    if (widget.meal == null) {
      _addMeal();
    } else {
      _updateMeal();
    }
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
                      context.pop();
                    },
                    icon: const Icon(Icons.close),
                  ),

                  Text(
                    widget.meal == null ? 'Add Meal' : 'Edit Meal',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  IconButton(
                    onPressed: () {
                      _saveMeal();
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

                  AppSpacing.horizontalLG,

                  Column(
                    children: [
                      InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: AppRadius.large,
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCategory = MealCategory.snack;
                          });
                        },
                        child: CategoryIcon(
                          icon: _selectedCategory == MealCategory.snack
                              ? Icons.apple
                              : Icons.apple_outlined,
                          iconColor: AppColors.snack,
                        ),
                      ),

                      AppSpacing.verticalSM,

                      Text(
                        'Snack',
                        style: _selectedCategory == MealCategory.snack
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
                        validator: (value) => AppValidators.positiveNumber(
                          value,
                          'meal calories',
                        ),
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
