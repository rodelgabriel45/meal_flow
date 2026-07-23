import 'package:uuid/uuid.dart';

enum MealCategory { breakfast, lunch, dinner, snack }

extension MealCategoryExtension on MealCategory {
  String get displayName {
    switch (this) {
      case MealCategory.breakfast:
        return 'Breakfast';
      case MealCategory.lunch:
        return 'Lunch';
      case MealCategory.dinner:
        return 'Dinner';
      case MealCategory.snack:
        return 'Snack';
    }
  }
}

class Meal {
  final String id;

  final String title;
  final int calories;

  final MealCategory category;

  final DateTime date;

  final bool isCompleted;
  final bool isFavorite;

  final String? imagePath;

  Meal({
    String? id,
    required this.title,
    required this.calories,
    required this.category,
    required this.date,
    this.isCompleted = false,
    this.isFavorite = false,
    this.imagePath,
  }) : id = id ?? Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'calories': calories,
      'category': category.name,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
      'imagePath': imagePath,
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      title: json['title'],
      calories: json['calories'],
      category: MealCategory.values.firstWhere(
        (c) => c.name == json['category'],
      ),
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
      imagePath: json['imagePath'],
    );
  }

  static const _unset = Object();

  Meal copyWith({
    String? title,
    int? calories,
    MealCategory? category,
    DateTime? date,
    bool? isCompleted,
    bool? isFavorite,

    Object? imagePath = _unset,
  }) {
    return Meal(
      id: id,
      title: title ?? this.title,
      calories: calories ?? this.calories,
      category: category ?? this.category,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      isFavorite: isFavorite ?? this.isFavorite,

      imagePath: imagePath == _unset ? this.imagePath : imagePath as String?,
    );
  }

  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;

  bool get isToday {
    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
