import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/settings/widgets/settings_header.dart';
import 'package:mealflow/features/settings/widgets/settings_sections.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              AppSpacing.verticalLG,

              SettingsHeader(),

              AppSpacing.verticalLG,

              SettingsSections(),
            ],
          ),
        ),
      ),
    );
  }
}
