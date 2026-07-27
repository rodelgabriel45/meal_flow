import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/home/widgets/show_nutrition_dialog.dart';
import 'package:mealflow/features/settings/providers/settings_provider.dart';
import 'package:mealflow/features/settings/widgets/settings_tile.dart';
import 'package:provider/provider.dart';

class SettingsSections extends StatelessWidget {
  const SettingsSections({super.key});

  void showThemePicker(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpacing.verticalSM,

              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),

              AppSpacing.verticalMD,

              Text('Appearance', style: Theme.of(context).textTheme.titleLarge),

              AppSpacing.verticalXS,

              Text(
                'Choose how MealFlow looks',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),

              Consumer<SettingsProvider>(
                builder: (context, provider, child) {
                  return RadioGroup<ThemeMode>(
                    groupValue: provider.themeMode,
                    onChanged: (ThemeMode? value) {
                      if (value != null) {
                        provider.changeTheme(value);
                      }
                    },
                    child: Column(
                      children: const [
                        RadioListTile<ThemeMode>(
                          value: ThemeMode.light,
                          title: Text('Light'),
                          secondary: Icon(Icons.light_mode),
                        ),
                        RadioListTile<ThemeMode>(
                          value: ThemeMode.dark,
                          title: Text('Dark'),
                          secondary: Icon(Icons.dark_mode),
                        ),
                        RadioListTile<ThemeMode>(
                          value: ThemeMode.system,
                          title: Text('System Default'),
                          secondary: Icon(Icons.brightness_auto),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.track_changes,
            title: 'Daily Goals',
            onTap: () => showEditNutritionDialog(context),
          ),

          SettingsTile(
            icon: Icons.dark_mode,
            title: 'App Theme',
            onTap: () => showThemePicker(context),
          ),

          SettingsTile(
            icon: Icons.info,
            title: 'About',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'MealFlow',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.restaurant_menu, size: 48),
                children: const [
                  Text(
                    'Smart Meal Planning Made Simple.\n\n'
                    'MealFlow helps you plan meals, organize groceries, and stay on top of your nutrition goals through a clean, modern, and intuitive experience.\n\n'
                    'Built with Flutter ❤️\n\n'
                    'Developed by Rod Gabriel.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
