 import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
   static const navyDark = Color(0xFF0F172A);    // For text and depth
  static const surfaceGrey = Color(0xFFF8FAFC); // Background
  static const successGreen = Color(0xFF10B981);
  static const sidebarBg = Color(0xFF0F172A);
  static const primaryBlue = Color(0xFF3B82F6);
  static const primaryGradient = [Color(0xFF3B82F6), Color(0xFF2563EB)];
  static const mainBg = Color(0xFFF8FAFC);
  static const cardBorder = Color(0xFFE2E8F0);
  static const textNavy = Color(0xFF0F172A);
  static const textSlate = Color(0xFF64748B);
  static const accentEmerald = Color(0xFF10B981);
  static const accentRose = Color(0xFFF43F5E);
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