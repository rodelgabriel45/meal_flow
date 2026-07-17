import 'package:uuid/uuid.dart';

enum MealCategory { breakfast, lunch, dinner }

extension MealCategoryExtension on MealCategory {
  String get displayName {
    switch (this) {
      case MealCategory.breakfast:
        return 'Breakfast';
      case MealCategory.lunch:
        return 'Lunch';
      case MealCategory.dinner:
        return 'Dinner';
    }
  }
}

class Meal {
  final String id;

  final String title;
  final int calories;

  final MealCategory category;

  bool isCompleted;

  Meal({
    String? id,
    required this.title,
    required this.calories,
    required this.category,
    this.isCompleted = false,
  }) : id = id ?? Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'calories': calories,
      'category': category.name,
      'isCompleted': isCompleted,
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
      isCompleted: json['isCompleted'],
    );
  }

  Meal copyWith({
    String? title,
    int? calories,
    MealCategory? category,
    bool? isCompleted,
  }) {
    return Meal(
      id: id,
      title: title ?? this.title,
      calories: calories ?? this.calories,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
