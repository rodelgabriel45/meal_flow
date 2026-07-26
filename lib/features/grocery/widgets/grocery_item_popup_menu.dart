import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mealflow/core/theme/app_spacing.dart';
import 'package:mealflow/features/grocery/helpers/show_grocery_form_sheet.dart';
import 'package:mealflow/features/grocery/models/grocery_item.dart';
import 'package:mealflow/features/grocery/providers/grocery_provider.dart';
import 'package:provider/provider.dart';

enum GroceryMenuAction { edit, delete }

class GroceryItemPopupMenu extends StatelessWidget {
  final GroceryItem item;
  const GroceryItemPopupMenu({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<GroceryMenuAction>(
      onSelected: (action) async {
        switch (action) {
          case GroceryMenuAction.edit:
            final updatedItem = await showGroceryFormSheet(context, item);

            debugPrint('UPDATEEEED ITEEEM: $updatedItem');

            if (updatedItem != null) {
              if (!context.mounted) return;

              await context.read<GroceryProvider>().updateItem(updatedItem);
            }

            break;

          case GroceryMenuAction.delete:
            final shouldDelete = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete Grocery Item'),
                  content: const Text(
                    'Are you sure you want to delete this item?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop(false);
                      },
                      child: const Text('Cancel'),
                    ),

                    TextButton(
                      onPressed: () {
                        context.pop(true);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );

            if (shouldDelete == true) {
              if (!context.mounted) return;

              await context.read<GroceryProvider>().removeItem(item.id);
            }

            break;
        }
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: GroceryMenuAction.edit,
            child: Row(
              children: [
                Icon(Icons.edit),

                AppSpacing.horizontalSM,

                Text('Edit'),
              ],
            ),
          ),

          PopupMenuItem(
            value: GroceryMenuAction.delete,
            child: Row(
              children: [
                Icon(Icons.delete),

                AppSpacing.horizontalSM,

                Text('Delete'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
