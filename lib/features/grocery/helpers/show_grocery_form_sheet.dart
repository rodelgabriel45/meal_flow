import 'package:flutter/material.dart';
import 'package:mealflow/features/grocery/models/grocery_item.dart';
import 'package:mealflow/features/grocery/widgets/grocery_form_sheet.dart';

Future<GroceryItem> showGroceryFormSheet(BuildContext context) async {
  final newItem = await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return const GroceryFormSheet();
    },
  );

  return newItem;
}
