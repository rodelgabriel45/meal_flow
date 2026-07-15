import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_theme.dart';
import 'package:mealflow/features/home/screens/home_screen.dart';

class MealFlow extends StatelessWidget {
  const MealFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomeScreen(),
    );
  }
}
