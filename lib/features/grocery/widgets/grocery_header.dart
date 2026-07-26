import 'package:flutter/material.dart';
import 'package:mealflow/features/grocery/helpers/show_grocery_form_sheet.dart';
import 'package:mealflow/features/grocery/providers/grocery_provider.dart';
import 'package:provider/provider.dart';

class GroceryHeader extends StatelessWidget {
  const GroceryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text('Grocery', style: Theme.of(context).textTheme.titleLarge),

        Align(
          alignment: Alignment.centerRight,
          child: IconButton.filled(
            onPressed: () async {
              final item = await showGroceryFormSheet(context);

              if (!context.mounted) return;

              context.read<GroceryProvider>().addItem(item);
            },
            icon: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
