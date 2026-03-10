import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Theme Colors - will be set dynamically based on selected theme
  static Color primary = const Color(0xFF14B8A6);
  static Color primaryLight = const Color(0xFF2DD4BF);
  static Color primaryDark = const Color(0xFF0D9488);
  
  static List<Color> primaryGradient = [
    const Color(0xFF14B8A6),
    const Color(0xFF06B6D4),
  ];

  // Accent Colors
  static const Color accent = Color(0xFFF97316);
  static const Color accentLight = Color(0xFFFB923C);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);

  // Light Theme
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textTertiaryLight = Color(0xFF94A3B8);
  static const Color dividerLight = Color(0xFFE2E8F0);

  // Dark Theme
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textTertiaryDark = Color(0xFF64748B);
  static const Color dividerDark = Color(0xFF334155);

  // Accent gradient
  static const List<Color> accentGradient = [
    Color(0xFFF97316),
    Color(0xFFEC4899),
  ];

  // Success gradient
  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF14B8A6),
  ];

  // Heatmap Colors (Light)
  static List<Color> heatmapLight = [
    const Color(0xFFE2E8F0),
    const Color(0xFFCCEBDD),
    const Color(0xFF5EAD8E),
    const Color(0xFF2D8A5F),
    const Color(0xFF0D6B3E),
  ];

  // Heatmap Colors (Dark)
  static List<Color> heatmapDark = [
    const Color(0xFF1E293B),
    const Color(0xFF134E4A),
    const Color(0xFF115E59),
    const Color(0xFF0D9488),
    const Color(0xFF14B8A6),
  ];

  // Habit Category Colors
  static const List<Color> habitColors = [
    Color(0xFF14B8A6), // Teal
    Color(0xFF10B981), // Emerald
    Color(0xFFF97316), // Orange
    Color(0xFF8B5CF6), // Violet
    Color(0xFFEC4899), // Pink
    Color(0xFF06B6D4), // Cyan
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Red
    Color(0xFF3B82F6), // Blue
    Color(0xFF84CC16), // Lime
  ];

  static void setTheme(AppThemeType themeType) {
    switch (themeType) {
      case AppThemeType.teal:
        primary = const Color(0xFF14B8A6);
        primaryLight = const Color(0xFF2DD4BF);
        primaryDark = const Color(0xFF0D9488);
        primaryGradient = [const Color(0xFF14B8A6), const Color(0xFF06B6D4)];
        heatmapLight = [
          const Color(0xFFE2E8F0),
          const Color(0xFFCCEBDD),
          const Color(0xFF5EAD8E),
          const Color(0xFF2D8A5F),
          const Color(0xFF0D6B3E),
        ];
        heatmapDark = [
          const Color(0xFF1E293B),
          const Color(0xFF134E4A),
          const Color(0xFF115E59),
          const Color(0xFF0D9488),
          const Color(0xFF14B8A6),
        ];
        break;
      case AppThemeType.pink:
        primary = const Color(0xFFEC4899);
        primaryLight = const Color(0xFFF472B6);
        primaryDark = const Color(0xFFDB2777);
        primaryGradient = [const Color(0xFFEC4899), const Color(0xFFF472B6)];
        heatmapLight = [
          const Color(0xFFE2E8F0),
          const Color(0xFFFCE7F3),
          const Color(0xFFF9A8D4),
          const Color(0xFFF472B6),
          const Color(0xFFEC4899),
        ];
        heatmapDark = [
          const Color(0xFF1E293B),
          const Color(0xFF4C1D3F),
          const Color(0xFF831843),
          const Color(0xFFBE185D),
          const Color(0xFFDB2777),
        ];
        break;
      case AppThemeType.lightBlue:
        primary = const Color(0xFF3B82F6);
        primaryLight = const Color(0xFF60A5FA);
        primaryDark = const Color(0xFF2563EB);
        primaryGradient = [const Color(0xFF3B82F6), const Color(0xFF06B6D4)];
        heatmapLight = [
          const Color(0xFFE2E8F0),
          const Color(0xFFBFDBFE),
          const Color(0xFF93C5FD),
          const Color(0xFF60A5FA),
          const Color(0xFF3B82F6),
        ];
        heatmapDark = [
          const Color(0xFF1E293B),
          const Color(0xFF1E3A5F),
          const Color(0xFF1E40AF),
          const Color(0xFF1D4ED8),
          const Color(0xFF2563EB),
        ];
        break;
    }
  }
}

enum AppThemeType {
  teal,
  pink,
  lightBlue,
}

extension AppThemeTypeExtension on AppThemeType {
  String get displayName {
    switch (this) {
      case AppThemeType.teal:
        return 'Teal';
      case AppThemeType.pink:
        return 'Pink';
      case AppThemeType.lightBlue:
        return 'Light Blue';
    }
  }

  Color get color {
    switch (this) {
      case AppThemeType.teal:
        return const Color(0xFF14B8A6);
      case AppThemeType.pink:
        return const Color(0xFFEC4899);
      case AppThemeType.lightBlue:
        return const Color(0xFF3B82F6);
    }
  }
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppRadius {
  AppRadius._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double full = 100.0;
}

class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration pageTransition = Duration(milliseconds: 350);
  static const Duration stagger = Duration(milliseconds: 50);
}
