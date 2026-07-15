import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  /// Very subtle shadow
  static const List<BoxShadow> small = [
    BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  /// Default card shadow
  static const List<BoxShadow> medium = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 4)),
  ];

  /// Floating cards
  static const List<BoxShadow> large = [
    BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 8)),
  ];
}
