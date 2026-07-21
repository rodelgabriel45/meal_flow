import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  const CategoryIcon({super.key, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: AppRadius.medium,
        color: AppColors.primaryContainer,
      ),
      child: Icon(icon, size: 25, color: iconColor),
    );
  }
}
