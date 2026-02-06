import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_porto/view/common/transitions.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.googleSansFlex().fontFamily,
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
      iconTheme: const IconThemeData(
        color: Color(0xFF1A1C1E),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
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
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SharedAxisBackTransitionsBuilder(),
          TargetPlatform.iOS: SharedAxisBackTransitionsBuilder(),
        },
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.googleSansFlex().fontFamily,
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
      iconTheme: const IconThemeData(
        color: Color(0xFFF5F7FA),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
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
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: SharedAxisBackTransitionsBuilder(),
          TargetPlatform.iOS: SharedAxisBackTransitionsBuilder(),
        },
      ),
    );
  }
}
