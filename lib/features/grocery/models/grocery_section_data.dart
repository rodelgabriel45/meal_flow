import 'package:mealflow/features/grocery/models/grocery_item.dart';

class GrocerySectionData {
  final String title;
  final GroceryStatus status;
  final List<GroceryItem> items;

  const GrocerySectionData({
    required this.title,
    required this.status,
    required this.items,
  });
}
