class User {
  final String name;
  final String title;

  final String? imagePath;

  const User({this.name = 'User', this.title = 'Meal Planner', this.imagePath});

  const User.empty() : name = 'User', title = 'MealPlanner', imagePath = null;

  User copyWith({String? name, String? title, String? imagePath}) {
    return User(
      name: name ?? this.name,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'title': title, 'imagePath': imagePath};
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? 'User',
      title: json['title'] ?? 'Meal Planner',
      imagePath: json['imagePath'],
    );
  }
}
