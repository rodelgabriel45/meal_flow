import 'package:flutter/material.dart';
import 'package:mealflow/core/theme/app_radius.dart';
import 'package:mealflow/core/theme/app_shadows.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/grocery/models/grocery_item.dart';
import 'package:mealflow/features/grocery/providers/grocery_provider.dart';
import 'package:mealflow/features/grocery/widgets/grocery_item_popup_menu.dart';
import 'package:provider/provider.dart';

class GroceryItemCard extends StatelessWidget {
  final GroceryItem item;
  const GroceryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: AppSpacing.cardPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: AppRadius.small,
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
                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      decoration: item.isPurchased
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  AppSpacing.verticalSM,

                  Text(item.category.displayName),
                ],
              ),
            ),

            Text(item.quantityText),

            GroceryItemPopupMenu(item: item),
          ],
        ),
      ),
    );
  }
}
