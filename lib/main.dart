import 'package:flutter/material.dart';
import 'package:in_porto/theme.dart';
import 'view/navigation/navigation_view.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: NavigationView(),
    );
  }
}
