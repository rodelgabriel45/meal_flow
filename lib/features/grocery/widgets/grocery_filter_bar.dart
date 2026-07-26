import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/grocery/providers/grocery_provider.dart';
import 'package:provider/provider.dart';

class GroceryFilterBar extends StatelessWidget {
  const GroceryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = context.watch<GroceryProvider>().selectedFilter;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        children: [
          FilterChip(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.extraLarge),
            label: const Text('All'),
            selected: selectedFilter == GroceryFilter.all,
            onSelected: (_) {
              context.read<GroceryProvider>().changeFilter(GroceryFilter.all);
            },
          ),

          AppSpacing.horizontalSM,

          FilterChip(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.extraLarge),
            label: const Text('To Buy'),
            selected: selectedFilter == GroceryFilter.toBuy,
            onSelected: (_) {
              context.read<GroceryProvider>().changeFilter(GroceryFilter.toBuy);
            },
          ),

          AppSpacing.horizontalSM,

          FilterChip(
            shape: RoundedRectangleBorder(borderRadius: AppRadius.extraLarge),
            label: const Text('Purchased'),
            selected: selectedFilter == GroceryFilter.purchased,
            onSelected: (_) {
              context.read<GroceryProvider>().changeFilter(
                GroceryFilter.purchased,
              );
            },
          ),
        ],
      ),
    );
  }
}
