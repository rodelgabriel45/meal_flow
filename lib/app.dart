import 'package:flutter/material.dart';
import 'package:mealflow/core/router/app_router.dart';
import 'package:mealflow/core/theme/app_theme.dart';
import 'package:mealflow/features/settings/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class MealFlow extends StatelessWidget {
  const MealFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<SettingsProvider>().themeMode,
      routerConfig: AppRouter.router,
    );
  }
}
