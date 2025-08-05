import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.manrope().fontFamily,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      cardTheme: CardThemeData(
        color: const Color(0xFFE9EDF3),
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: const Color(0xFF0F2F7F),
            brightness: Brightness.light,
          ).copyWith(
            surface: const Color(0xFFF5F7FA),
            surfaceContainer: const Color(0xFFE9EDF3),
            onSurface: const Color(0xFF1A1C1E),
          ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.manrope().fontFamily,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF181A20),
      cardTheme: CardThemeData(
        color: const Color(0xFF23262B),
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: const Color(0xFF0F2F7F),
            brightness: Brightness.dark,
          ).copyWith(
            surface: const Color(0xFF181A20),
            surfaceContainer: const Color(0xFF23262B),
            onSurface: const Color(0xFFF5F7FA),
          ),
    );
  }
}
