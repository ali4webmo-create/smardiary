import 'package:flutter/material.dart';

class LeatherTheme {
  static const Color backgroundDark = Color(0xFF1E1E1E);
  static const Color leatherDark = Color(0xFF3E2723);
  static const Color leatherLight = Color(0xFF5D4037);
  static const Color brownWarm = Color(0xFF8B5A32);
  static const Color gold = Color(0xFFD7A65C);
  static const Color paperCream = Color(0xFFFAF6ED);
  static const Color paperDark = Color(0xFFEADCC6);
  static const Color textDark = Color(0xFF2C211B);
  static const Color textDim = Color(0xFF75685C);
  static const Color stitch = Color(0xFFC9B69B);

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textDark,
  );
  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textDark,
  );
  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: textDark,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: textDim,
  );
  static const TextStyle goldLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: gold,
  );
}