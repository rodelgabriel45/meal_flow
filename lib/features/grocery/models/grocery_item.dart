import 'package:uuid/uuid.dart';

enum GroceryStatus { toBuy, purchased }

enum GroceryCategory {
  meat,
  dairy,
  vegetables,
  fruits,
  grains,
  pantry,
  frozen,
  drinks,
  others,
}

extension GroceryCategoryExtension on GroceryCategory {
  String get displayName {
    switch (this) {
      case GroceryCategory.meat:
        return 'Meat';
      case GroceryCategory.dairy:
        return 'Dairy';
      case GroceryCategory.vegetables:
        return 'Vegetables';
      case GroceryCategory.fruits:
        return 'Fruits';
      case GroceryCategory.grains:
        return 'Grains';
      case GroceryCategory.pantry:
        return 'Pantry';
      case GroceryCategory.frozen:
        return 'Frozen';
      case GroceryCategory.drinks:
        return 'Drinks';
      case GroceryCategory.others:
        return 'Others';
    }
  }

  String get emoji {
    switch (this) {
      case GroceryCategory.meat:
        return '🍗';

      case GroceryCategory.dairy:
        return '🥚';

      case GroceryCategory.fruits:
        return '🍌';

      case GroceryCategory.vegetables:
        return '🥦';

      case GroceryCategory.grains:
        return '🌾';

      case GroceryCategory.pantry:
        return '🫙';

      case GroceryCategory.frozen:
        return '🧊';

      case GroceryCategory.drinks:
        return '🥤';

      case GroceryCategory.others:
        return '🛒';
    }
  }
}

class GroceryItem {
  final String id;
  final String name;
  final GroceryCategory category;
  final double quantity;
  final String unit;
  final String emoji;
  final GroceryStatus status;

  GroceryItem({
    String? id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    required this.emoji,
    this.status = GroceryStatus.toBuy,
  }) : id = id ?? Uuid().v4();

  bool get isPurchased => status == GroceryStatus.purchased;

  String get quantityText {
    final value = quantity % 1 == 0
        ? quantity.toInt().toString()
        : quantity.toString();

    return '$value $unit';
  }

  GroceryItem copyWith({
    String? id,
    String? name,
    GroceryCategory? category,
    double? quantity,
    String? unit,
    String? emoji,
    GroceryStatus? status,
  }) {
    return GroceryItem(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      emoji: emoji ?? this.emoji,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'unit': unit,
      'emoji': emoji,
      'status': status.name,
    };
  }

  factory GroceryItem.fromJson(Map<String, dynamic> json) {
    return GroceryItem(
      id: json['id'],
      name: json['name'],
      category: GroceryCategory.values.firstWhere(
        (value) => value.name == json['category'],
      ),
      quantity: json['quantity'],
      unit: json['unit'],
      emoji: json['emoji'],
      status: GroceryStatus.values.firstWhere(
        (value) => value.name == json['status'],
      ),
    );
  }
}
