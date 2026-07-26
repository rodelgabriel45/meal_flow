import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_colors.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/grocery/models/grocery_item.dart';
import 'package:mealflow/features/grocery/providers/grocery_provider.dart';
import 'package:provider/provider.dart';

class GroceryItemCard extends StatelessWidget {
  final GroceryItem item;
  const GroceryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.medium,
        boxShadow: AppShadows.small,
      ),
      child: Row(
        children: [
          Checkbox(
            value: item.isPurchased,
            onChanged: (_) {
              context.read<GroceryProvider>().toggleStatus(item.id);
            },
          ),

          Text(item.emoji, style: const TextStyle(fontSize: 24)),

          AppSpacing.horizontalMD,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: Theme.of(context).textTheme.titleMedium),

                AppSpacing.verticalSM,

                Text(item.category.displayName),
              ],
            ),
          ),

          Text(item.quantityText),

          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}
