import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF2563EB),
        secondary: Color(0xFF7C3AED),
        surface: Color(0xFFFAFAFA),
        background: Color(0xFFFFFFFF),
        onSurface: Color(0xFF0F172A),
        onBackground: Color(0xFF1E293B),
      ),
      fontFamily: 'SF Pro Display',
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF3B82F6),
        secondary: Color(0xFF8B5CF6),
        surface: Color(0xFF1E293B),
        background: Color(0xFF0F172A),
        onSurface: Color(0xFFF1F5F9),
        onBackground: Color(0xFFE2E8F0),
      ),
      fontFamily: 'SF Pro Display',
      scaffoldBackgroundColor: const Color(0xFF0F172A),
    );
  }
}