import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  // =========================================================
  // Spacing Scale
  // =========================================================

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // =========================================================
  // Page Padding
  // =========================================================

  static const EdgeInsets pagePadding = EdgeInsets.all(md);

  static const EdgeInsets pageHorizontal = EdgeInsets.symmetric(horizontal: md);

  static const EdgeInsets pageVertical = EdgeInsets.symmetric(vertical: md);

  // =========================================================
  // Card Padding
  // =========================================================

  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  // =========================================================
  // Button Padding
  // =========================================================

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );

  // =========================================================
  // TextField Padding
  // =========================================================

  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: md,
  );

  // =========================================================
  // List Item Padding
  // =========================================================

  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // =========================================================
  // Section Spacing
  // =========================================================

  static const SizedBox verticalXS = SizedBox(height: xs);
  static const SizedBox verticalSM = SizedBox(height: sm);
  static const SizedBox verticalMD = SizedBox(height: md);
  static const SizedBox verticalLG = SizedBox(height: lg);
  static const SizedBox verticalXL = SizedBox(height: xl);
  static const SizedBox verticalXXL = SizedBox(height: xxl);

  static const SizedBox horizontalXS = SizedBox(width: xs);
  static const SizedBox horizontalSM = SizedBox(width: sm);
  static const SizedBox horizontalMD = SizedBox(width: md);
  static const SizedBox horizontalLG = SizedBox(width: lg);
  static const SizedBox horizontalXL = SizedBox(width: xl);
}
