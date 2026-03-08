import 'package:flutter/material.dart';

// ─── Theme Notifier (singleton ValueNotifier) ───
class ThemeNotifier extends ValueNotifier<bool> {
  ThemeNotifier._() : super(true); // true = dark (Midnight)
  static final ThemeNotifier instance = ThemeNotifier._();

  bool get isDark => value;

  void setDark() {
    AuraColors._isDark = true;
    value = true;
  }

  void setLight() {
    AuraColors._isDark = false;
    value = false;
  }
}

// ─── Dynamic Color Palette ───
class AuraColors {
  AuraColors._();

  static bool _isDark = true;
  static bool get isDark => _isDark;

  // ── Backgrounds (deepest → surface) ──
  static Color get midnight =>
      _isDark ? const Color(0xFF0A0A0B) : const Color(0xFFF8F7F4);
  static Color get charcoal =>
      _isDark ? const Color(0xFF121214) : const Color(0xFFF0EDE8);
  static Color get obsidian =>
      _isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);

  // ── Typography ──
  static Color get chrome =>
      _isDark ? const Color(0xFFE5E7EB) : const Color(0xFF2D2D2D);

  // ── Accent (stays constant) ──
  static const Color sage = Color(0xFF9DB4A0);

  // ── Dynamic helpers (replace hardcoded Colors.white) ──
  static Color get textPrimary =>
      _isDark ? Colors.white : const Color(0xFF1A1A1A);
  static Color get textSecondary => textPrimary.withOpacity(0.5);
  static Color get textTertiary => textPrimary.withOpacity(0.3);
  static Color get borderSubtle =>
      _isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.06);
  static Color get borderMedium =>
      _isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.08);
  static Color get surfaceOverlay =>
      _isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03);
}

// ─── Theme Builder ───
class AuraTheme {
  static ThemeData buildTheme() {
    final isDark = AuraColors.isDark;
    final base = isDark ? ThemeData.dark() : ThemeData.light();

    return base.copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: AuraColors.midnight,
      colorScheme: base.colorScheme.copyWith(
        primary: AuraColors.sage,
        secondary: AuraColors.chrome,
        surface: AuraColors.obsidian,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      textTheme: _buildTextTheme(
        base.textTheme.apply(fontFamily: 'Inter'),
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      bodyMedium: base.bodyMedium?.copyWith(color: AuraColors.chrome),
    );
  }
}

