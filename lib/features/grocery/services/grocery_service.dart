import 'dart:convert';

import 'package:mealflow/features/grocery/models/grocery_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroceryService {
  static const _key = 'grocery_items';

  Future<void> saveGroceryItems(List<GroceryItem> items) async {
    final prefs = await SharedPreferences.getInstance();

    final itemsJson = items.map((item) => item.toJson()).toList();

    final itemsString = jsonEncode(itemsJson);

    await prefs.setString(_key, itemsString);
  }

  Future<List<GroceryItem>> loadGroceryItems() async {
    final prefs = await SharedPreferences.getInstance();

    final itemsString = prefs.getString(_key);

    if (itemsString == null) {
      return [];
    }

    final itemsJson = jsonDecode(itemsString);

    return (itemsJson as List)
        .map((json) => GroceryItem.fromJson(json))
        .toList();
  }
}
