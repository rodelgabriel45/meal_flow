import 'package:flutter/material.dart';
import 'package:mealflow/features/grocery/models/grocery_item.dart';
import 'package:mealflow/features/grocery/models/grocery_section_data.dart';
import 'package:mealflow/features/grocery/services/grocery_service.dart';

enum GroceryFilter { all, toBuy, purchased }

class GroceryProvider extends ChangeNotifier {
  final GroceryService _groceryService = GroceryService();

  final List<GroceryItem> _items = [];
  List<GroceryItem> get items => List.unmodifiable(_items);

  List<GroceryItem> get toBuyItems =>
      _items.where((item) => item.status == GroceryStatus.toBuy).toList();

  List<GroceryItem> get purchasedItems =>
      _items.where((item) => item.status == GroceryStatus.purchased).toList();

  List<GrocerySectionData> get sections {
    switch (_selectedFilter) {
      case GroceryFilter.all:
        return [
          GrocerySectionData(
            title: 'To Buy',
            status: GroceryStatus.toBuy,
            items: toBuyItems,
          ),

          GrocerySectionData(
            title: 'Purchased',
            status: GroceryStatus.purchased,
            items: purchasedItems,
          ),
        ];

      case GroceryFilter.toBuy:
        return [
          GrocerySectionData(
            title: 'To Buy',
            status: GroceryStatus.toBuy,
            items: toBuyItems,
          ),
        ];

      case GroceryFilter.purchased:
        return [
          GrocerySectionData(
            title: 'Purchased',
            status: GroceryStatus.purchased,
            items: purchasedItems,
          ),
        ];
    }
  }

  int get totalCount => _items.length;

  int get toBuyCount => toBuyItems.length;

  int get purchasedCount => purchasedItems.length;

  GroceryFilter _selectedFilter = GroceryFilter.all;

  GroceryFilter get selectedFilter => _selectedFilter;

  void changeFilter(GroceryFilter filter) {
    _selectedFilter = filter;

    notifyListeners();
  }

  GroceryProvider() {
    loadGroceryItems();
  }

  Future<void> addItem(GroceryItem item) async {
    _items.add(item);

    await _groceryService.saveGroceryItems(_items);

    notifyListeners();
  }

  Future<void> removeItem(String id) async {
    _items.removeWhere((item) => item.id == id);

    await _groceryService.saveGroceryItems(_items);

    notifyListeners();
  }

  Future<void> updateItem(GroceryItem updatedItem) async {
    final index = _items.indexWhere((item) => item.id == updatedItem.id);

    debugPrint('INDEXXXXX: $index');

    if (index == -1) return;

    _items[index] = updatedItem;

    await _groceryService.saveGroceryItems(_items);

    notifyListeners();
  }

  Future<void> toggleStatus(String id) async {
    final index = _items.indexWhere((item) => item.id == id);

    if (index == -1) return;

    final item = _items[index];

    _items[index] = item.copyWith(
      status: item.isPurchased ? GroceryStatus.toBuy : GroceryStatus.purchased,
    );

    await _groceryService.saveGroceryItems(_items);

    notifyListeners();
  }

  Future<void> loadGroceryItems() async {
    final loadedItems = await _groceryService.loadGroceryItems();

    _items
      ..clear()
      ..addAll(loadedItems);

    notifyListeners();
  }
}
