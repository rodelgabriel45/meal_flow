import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // =========================================================
  // Display
  // =========================================================

  static TextStyle get displayLarge =>
      GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, height: 1.2);

  static TextStyle get displayMedium =>
      GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w700, height: 1.2);

  // =========================================================
  // Headlines
  // =========================================================

  static TextStyle get headlineLarge =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get headlineMedium =>
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3);

  // =========================================================
  // Titles
  // =========================================================

  static TextStyle get titleLarge =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get titleMedium =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, height: 1.4);

  // =========================================================
  // Body
  // =========================================================

  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);

  static TextStyle get bodyMedium =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);

  // =========================================================
  // Labels
  // =========================================================

  static TextStyle get labelLarge =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, height: 1.4);

  static TextStyle get labelMedium =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, height: 1.4);

  static TextStyle get labelSmall =>
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, height: 1.4);
}
