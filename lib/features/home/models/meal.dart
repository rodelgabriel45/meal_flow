enum MealCategory { breakfast, lunch, dinner }

class Meal {
  final String title;
  final int calories;

  final MealCategory category;

  bool isCompleted;

  Meal({
    required this.title,
    required this.calories,
    required this.category,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'calories': calories,
      'category': category.name,
      'isCompleted': isCompleted,
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      title: json['title'],
      calories: json['calories'],
      category: MealCategory.values.firstWhere(
        (c) => c.name == json['category'],
      ),
      isCompleted: json['isCompleted'],
    );
  }
}
