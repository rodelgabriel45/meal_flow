import 'dart:io';

import 'package:flutter/material.dart';

class MealImage extends StatelessWidget {
  final String? imagePath;
  const MealImage({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return Image.asset('assets/images/default_meal.png', fit: BoxFit.cover);
    }

    return Image.file(File(imagePath!), fit: BoxFit.cover);
  }
}
