import 'package:flutter/material.dart';
import 'package:in_porto/service/settings_service.dart';
import 'package:in_porto/viewmodel/settings_viewmodel.dart';
import 'package:in_porto/theme.dart';
import 'package:provider/provider.dart';
import 'view/navigation/navigation_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsService = SettingsService();
  final settingsViewModel = SettingsViewModel(settingsService);
  await settingsViewModel.load();

  runApp(
    ChangeNotifierProvider<SettingsViewModel>.value(
      value: settingsViewModel,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appearance = context.watch<SettingsViewModel>().settings.appearance;
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appearance == 'dark' ? ThemeMode.dark : appearance == 'light' ? ThemeMode.light : ThemeMode.system,
      home: NavigationView(),
    );
  }
}
