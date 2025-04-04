import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFFE94F8B); // Pink for Instagram-like app
  static const Color accent = Color(0xFF833AB4); // Purple accent

  // Text Colors
  static const Color textDark = Color(0xFF303030);
  static const Color textLight = Color(0xFFF5F5F5);
  static const Color textGrey = Color(0xFF757575);
  static const Color textGreyLight = Color(0xFFBDBDBD);

  // Background Colors
  static const Color backgroundLight = Color(0xFFF8F8F8);
  static const Color backgroundDark = Color(0xFF121212);

  // Card Colors
  static const Color cardDark = Color(0xFF1E1E1E);

  // Input Field Colors
  static const Color inputFillLight = Color(0xFFF0F0F0);
  static const Color inputFillDark = Color(0xFF2A2A2A);

  // Divider Colors
  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x1A000000);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Feature-specific Colors
  static const Color gridLines = Color(0x40E0E0E0);
  static const Color gridLinesDark = Color(0x40616161);

  // Instagram Gradient
  static const List<Color> instagramGradient = [
    // Color(0xFFFEDA77),
    // Color(0xFFF58529),
    // Color(0xFFDD2A7B),
    // Color(0xFF8134AF),
    // Color(0xFF515BD4),
    Color(0xFF405DE6),
    Color(0xFF5851DB),
    Color(0xFF833AB4),
    Color(0xFFC13584),
    Color(0xFFE1306C),
    Color(0xFFFD1D1D),
  ];
}
