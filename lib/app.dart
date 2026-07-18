import 'package:flutter/material.dart';
import 'package:mealflow/core/router/app_router.dart';
import 'package:mealflow/core/theme/app_theme.dart';

class MealFlow extends StatelessWidget {
  const MealFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
