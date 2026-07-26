import 'package:flutter/material.dart';
import 'package:mealflow/features/grocery/models/grocery_item.dart';
import 'package:mealflow/features/grocery/widgets/grocery_form_sheet.dart';

Future<GroceryItem?> showGroceryFormSheet(
  BuildContext context,
  GroceryItem? item,
) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return item != null ? GroceryFormSheet(item: item) : GroceryFormSheet();
    },
  );
}
