class Nutrition {
  final int targetCalories;
  final int targetWater;
  final int currentWater;

  const Nutrition({
    required this.targetCalories,
    required this.targetWater,
    this.currentWater = 0,
  });

  static const Nutrition defaults = Nutrition(
    targetCalories: 2200,
    targetWater: 8,
  );

  Map<String, dynamic> toJson() {
    return {
      'targetCalories': targetCalories,
      'targetWater': targetWater,
      'currentWater': currentWater,
    };
  }

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      targetCalories: json['targetCalories'],
      targetWater: json['targetWater'],
      currentWater: json['currentWater'],
    );
  }

  Nutrition copyWith({
    int? targetCalories,
    int? targetWater,
    int? currentWater,
  }) {
    return Nutrition(
      targetCalories: targetCalories ?? this.targetCalories,
      targetWater: targetWater ?? this.targetWater,
      currentWater: currentWater ?? this.currentWater,
    );
  }
}
