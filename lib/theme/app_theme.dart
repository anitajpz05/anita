import 'package:flutter/material.dart';

/// Colors and category palette lifted from the Diseño.pen design tokens.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4F46E5);
  static const Color primarySoft = Color(0xFF3A32A0);
  static const Color primaryLight = Color(0xFFA5B4FC);

  static const Color bg = Color(0xFF231C6B);
  static const Color surface = Color(0xFF2E2789);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFC5BFEE);
  static const Color textTertiary = Color(0xFF948CCB);

  static const Color border = Color(0xFF443BA5);

  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color favorite = Color(0xFFF43F5E);

  static const Color onBg = Color(0xFFFFFFFF);
  static const Color onBgMuted = Color(0xB3FFFFFF);
  static const Color onBgSubtle = Color(0x80FFFFFF);
}

/// Category name -> (solid color, light accent color).
class CategoryPalette {
  final Color solid;
  final Color light;
  const CategoryPalette(this.solid, this.light);
}

const Map<String, CategoryPalette> kCategoryPalettes = {
  'Flutter': CategoryPalette(Color(0xFF0553B1), Color(0xFF54C5F8)),
  'Android': CategoryPalette(Color(0xFF1DA260), Color(0xFF4ADE80)),
  'Layouts': CategoryPalette(Color(0xFFF59E0B), Color(0xFFFCD34D)),
  'Scrollables': CategoryPalette(Color(0xFFDB2777), Color(0xFFF9A8D4)),
  'Slivers': CategoryPalette(Color(0xFF7C3AED), Color(0xFFC4B5FD)),
  'Navegacion': CategoryPalette(Color(0xFFDC2626), Color(0xFFFCA5A5)),
};

const List<String> kCategories = [
  'Flutter',
  'Android',
  'Layouts',
  'Scrollables',
  'Slivers',
  'Navegacion',
];

CategoryPalette paletteFor(String category) =>
    kCategoryPalettes[category] ?? const CategoryPalette(AppColors.primary, AppColors.primaryLight);

ThemeData buildAppTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.primary,
      surface: AppColors.surface,
      error: AppColors.danger,
    ),
    primaryColor: AppColors.primary,
    dividerColor: AppColors.border,
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      elevation: 0,
      foregroundColor: AppColors.onBg,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        side: BorderSide(color: AppColors.border),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.bg,
      selectedItemColor: AppColors.onBg,
      unselectedItemColor: AppColors.onBgSubtle,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      hintStyle: const TextStyle(color: AppColors.textTertiary),
    ),
  );
}
