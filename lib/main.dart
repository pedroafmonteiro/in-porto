import 'package:flutter/material.dart';
import 'package:in_porto/service/database_service.dart';
import 'package:in_porto/service/gtfs_service.dart';
import 'package:in_porto/view/onboarding/onboarding_view.dart';
import 'package:in_porto/viewmodel/connectivity_viewmodel.dart';
import 'package:in_porto/viewmodel/settings_viewmodel.dart';
import 'package:in_porto/theme.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'view/navigation/navigation_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsViewModel = SettingsViewModel();
  await settingsViewModel.load();

  final databaseService = DatabaseService();
  final db = await databaseService.db;

  final gtfsService = GTFSService();
  gtfsService.setDatabase(db);
  await gtfsService.ensureGtfsDataLoadedAndPrint();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsViewModel>.value(
          value: settingsViewModel,
        ),
        ChangeNotifierProvider<ConnectivityViewmodel>.value(
          value: ConnectivityViewmodel(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appearance = context.watch<SettingsViewModel>().settings.appearance;
    final hasSeenOnboarding = context
        .watch<SettingsViewModel>()
        .settings
        .hasSeenOnboarding;
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appearance == 'dark'
          ? ThemeMode.dark
          : appearance == 'light'
          ? ThemeMode.light
          : ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<SettingsViewModel>().settings.language == 'system'
          ? null
          : Locale(context.watch<SettingsViewModel>().settings.language),
      home: OnboardingView(),
    );
  }
}
