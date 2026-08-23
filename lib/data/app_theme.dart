import 'package:flutter/material.dart';

/// Tema do app — rosé/coral (bonito, delicado, pôr do sol).
class AppTheme {
  AppTheme._();

  static const brand = Color(0xFFFF5E8A); // rosé/coral
  static const brandDark = Color(0xFFC73866);
  static const gold = Color(0xFFFFC2D6);

  /// Gradiente da "frase do dia" e da marca.
  static const hero = [Color(0xFFFF758C), Color(0xFFFF7EB3)];

  static LinearGradient gradient(List<Color> colors) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      );

  static ThemeData light([Color accent = brand]) {
    return ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.light),
      scaffoldBackgroundColor: const Color(0xFFFFF5F8),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );
  }

  static ThemeData dark([Color accent = brand]) {
    return ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.dark),
      scaffoldBackgroundColor: const Color(0xFF1A0E14),
      appBarTheme: const AppBarTheme(centerTitle: false),
    );
  }
}
