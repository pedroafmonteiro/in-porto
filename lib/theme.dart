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
        margin: const EdgeInsets.all(0),
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
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFF5F7FA),
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF1A1C1E),
          backgroundColor: const Color(0xFFE9EDF3),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        backgroundColor: const Color(0xFFF5F7FA),
        foregroundColor: const Color(0xFF1A1C1E),
      ),
      colorScheme: ColorScheme.light(
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
        margin: const EdgeInsets.all(0),
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
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF181A20),
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFF5F7FA),
          backgroundColor: const Color(0xFF23262B),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        backgroundColor: const Color(0xFF181A20),
        foregroundColor: const Color(0xFFF5F7FA),
      ),
      colorScheme: ColorScheme.dark(
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
