import 'package:flutter/material.dart';

/// AppColor provides unified, subtle, modern color tokens for Learnova.
/// Palette centered on #F9F9FD (Canvas), #123D67 (Primary Navy), #F18D1F (Accent Amber).
class AppColor {
  // Primary Palette (#123D67 & #F18D1F)
  static const Color primary = Color(0xFF123D67); // Deep Navy Blue
  static const Color primaryDark = Color(0xFF0B2545);
  static const Color primaryLight = Color(0xFF245586);
  static const Color primarySubtle = Color(0xFFE8EEF5); // Soft blue tint for light cards

  static const Color accent = Color(0xFFF18D1F); // Warm Amber Orange
  static const Color accentLight = Color(0xFFFFF4E8); // Subtle orange tint
  static const Color accentSecondary = Color(0xFFE57C10);

  // Background & Surface (#F9F9FD)
  static const Color background = Color(0xFFF9F9FD); // Soft Ice Lavender White
  static const Color surface = Color(0xFFFFFFFF); // Pure Crisp White
  static const Color surfaceLight = Color(0xFFF1F5F9); // Light Grayish Blue
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E8F0); // Subtle thin border

  // Status Colors (Subtle & Elegant)
  static const Color mastered = Color(0xFF0D9488); // Teal Emerald Green
  static const Color masteredLight = Color(0xFFCCFBF1);
  static const Color strong = Color(0xFF123D67); // Navy
  static const Color needsImprovement = Color(0xFFF18D1F); // Warm Orange
  static const Color missing = Color(0xFFE11D48); // Rose Red
  static const Color missingLight = Color(0xFFFFE4E6);
  static const Color warning = Color(0xFFD97706);

  // Text Hierarchy
  static const Color textPrimary = Color(0xFF0F2942); // Rich Navy Slate
  static const Color textSecondary = Color(0xFF475569); // Slate Gray
  static const Color textMuted = Color(0xFF94A3B8); // Light Slate Muted
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Structural & Decorative
  static const Color chipBackground = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE2E8F0);
  static const Color shadow = Color(0x0F123D67); // Very subtle soft elevation shadow
  static const Color transparent = Colors.transparent;

  // Subtle Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF123D67), Color(0xFF1F5286)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFF18D1F), Color(0xFFF5A347)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF123D67), Color(0xFF1A4978), Color(0xFF2E659E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

extension ColorValuesExt on Color {
  Color withAlphaValue(double alpha) {
    return withValues(alpha: alpha);
  }
}
