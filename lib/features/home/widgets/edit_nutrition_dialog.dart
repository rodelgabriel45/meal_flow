import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/core/validators/app_validators.dart';
import 'package:mealflow/features/home/providers/nutrition_provider.dart';
import 'package:provider/provider.dart';

class EditNutritionDialog extends StatefulWidget {
  const EditNutritionDialog({super.key});

  @override
  State<EditNutritionDialog> createState() => _EditNutritionDialogState();
}

class _EditNutritionDialogState extends State<EditNutritionDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _caloriesController;
  late TextEditingController _waterController;

  @override
  void initState() {
    super.initState();

    final nutrition = context.read<NutritionProvider>().nutrition;

    _caloriesController = TextEditingController(
      text: nutrition.targetCalories.toString(),
    );
    _waterController = TextEditingController(
      text: nutrition.targetWater.toString(),
    );
  }

  @override
  void dispose() {
    _caloriesController.dispose();
    _waterController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Nutrition'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Target Calories',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            AppSpacing.verticalSM,
            TextFormField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) =>
                  AppValidators.positiveNumber(value, 'meal calories'),
            ),

            AppSpacing.verticalMD,

            Text(
              'Target Water',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            AppSpacing.verticalSM,
            TextFormField(
              controller: _waterController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) =>
                  AppValidators.positiveNumber(value, 'target water'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancel'),
        ),

        TextButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) {
              return;
            }

            context.read<NutritionProvider>().updateTargets(
              calories: int.parse(_caloriesController.text),
              water: int.parse(_waterController.text),
            );

            context.pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
