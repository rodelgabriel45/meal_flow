import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/core/validators/app_validators.dart';
import 'package:mealflow/features/home/models/meal.dart';
import 'package:mealflow/features/home/providers/meal_provider.dart';
import 'package:mealflow/features/home/widgets/add_favorite_button.dart';
import 'package:mealflow/features/home/widgets/category_icon.dart';
import 'package:provider/provider.dart';

class MealFormScreen extends StatefulWidget {
  final Meal? meal;
  final MealCategory? category;
  final DateTime date;
  final bool? isEditing;
  const MealFormScreen({
    super.key,
    this.meal,
    this.category,
    required this.date,
    this.isEditing,
  });

  @override
  State<MealFormScreen> createState() => _MealFormScreenState();
}

class _MealFormScreenState extends State<MealFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _mealNameController;
  late TextEditingController _caloriesController;

  bool _isFavorite = false;

  late MealCategory _selectedCategory;

  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();

    _isFavorite = widget.meal?.isFavorite ?? false;

    _selectedImage = widget.meal?.imagePath != null
        ? File(widget.meal!.imagePath!)
        : null;

    _selectedCategory =
        widget.category ?? widget.meal?.category ?? MealCategory.breakfast;

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
        imagePath: _selectedImage?.path,
      ),
    );

    context.pop();
  }

  void _updateMeal() {
    final updatedMeal = widget.meal!.copyWith(
      title: _mealNameController.text.trim(),
      calories: int.parse(_caloriesController.text),
      category: _selectedCategory,
      imagePath: _selectedImage?.path,
      isFavorite: _isFavorite,
    );

    context.read<MealProvider>().updateMeal(updatedMeal);

    context.pop();
  }

  void _saveMeal() {
    if (!_formKey.currentState!.validate()) return;

    if (widget.isEditing == true) {
      _updateMeal();
    } else {
      _addMeal();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Meal Photo',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              Divider(),

              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () async {
                  context.pop();

                  await _pickImage(ImageSource.camera);
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  context.pop();

                  await _pickImage(ImageSource.gallery);
                },
              ),

              if (_selectedImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Remove Photo'),
                  onTap: () {
                    context.pop();

                    setState(() {
                      _selectedImage = null;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void tapFavoriteButton() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: SingleChildScrollView(
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
                      widget.isEditing == true ? 'Edit Meal' : 'Add Meal',
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

                Center(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: _showImagePickerOptions,
                        child: SizedBox(
                          height: 160,
                          width: 160,
                          child: _selectedImage == null
                              ? const Icon(Icons.add_a_photo, size: 40)
                              : ClipRRect(
                                  borderRadius: AppRadius.medium,
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),

                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: _showImagePickerOptions,
                            icon: Icon(Icons.camera_alt),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                AppSpacing.verticalMD,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          borderRadius: AppRadius.medium,
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
                              ? Theme.of(
                                  context,
                                ).textTheme.labelLarge?.copyWith(
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
                          borderRadius: AppRadius.medium,
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
                              ? Theme.of(
                                  context,
                                ).textTheme.labelLarge?.copyWith(
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
                          borderRadius: AppRadius.medium,
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
                              ? Theme.of(
                                  context,
                                ).textTheme.labelLarge?.copyWith(
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
                          borderRadius: AppRadius.medium,
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
                              ? Theme.of(
                                  context,
                                ).textTheme.labelLarge?.copyWith(
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

                AppSpacing.verticalMD,

                if (widget.isEditing == true)
                  AddFavoriteButton(
                    isFavorite: _isFavorite,
                    onPressed: tapFavoriteButton,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
