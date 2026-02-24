 import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const primaryBlue = Color(0xFF0EA5E9); // Modern Light Blue
  static const navyDark = Color(0xFF0F172A);    // For text and depth
  static const surfaceGrey = Color(0xFFF8FAFC); // Background
  static const successGreen = Color(0xFF10B981);
}

ThemeData medicalTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryBlue,
    onPrimary: Colors.white,
    surface: AppColors.surfaceGrey,
  ),
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    color: Colors.white,
  ),
);