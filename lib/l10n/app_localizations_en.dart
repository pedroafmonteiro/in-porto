// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'In Porto.';

  @override
  String get appDescription => 'Explore Porto like never before.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get downloadDataTitle => 'Download Data';

  @override
  String get downloadDataText1 =>
      'To use this app, you will need to connect to the internet at least once to download essential information from the cloud.';

  @override
  String get downloadDataText2 =>
      'All data is publicly available and relates to the city of Porto. No private information or analytics are collected that could identify you.';

  @override
  String get downloadDataText3 =>
      'This process may take a few minutes, depending on your internet connection and the amount of data being downloaded.';

  @override
  String get downloadDataText4 =>
      'Do not close the app or turn off your device during this process.';

  @override
  String get continueText => 'Continue';

  @override
  String get finishText => 'Finish';

  @override
  String get connectivitySuccess => 'Connected to the internet.';

  @override
  String get connectivityError => 'No internet connection.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get system => 'System';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get lightMode => 'Light';

  @override
  String get darkMode => 'Dark';

  @override
  String get languageTitle => 'Language';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get english => 'English';

  @override
  String get publicTransportationTitle => 'Public Transportation';

  @override
  String get metrodoporto => 'Metro do Porto';

  @override
  String get stcp => 'STCP';

  @override
  String get stcpFull => 'Sociedade de Transportes Coletivos do Porto';

  @override
  String get cp => 'CP';

  @override
  String get cpFull => 'Comboios de Portugal';

  @override
  String get openSourceLicensesTitle => 'Open Source Licenses';

  @override
  String get license => 'license';

  @override
  String get supportMessage => 'Made with ❤️ in Porto';

  @override
  String get debugSettingsTitle => 'Debug Settings';

  @override
  String get resetOnboarding => 'Reset Onboarding';

  @override
  String get resetOnboardingText1 =>
      'Are you sure you want to reset the onboarding process?';

  @override
  String get resetOnboardingText2 => 'This will remove all GTFS data.';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get search => 'Search';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get olderDepartures => 'See older departures from today';

  @override
  String get done => 'Done';

  @override
  String get now => 'Now';

  @override
  String get realtime => 'Realtime';

  @override
  String get scheduled => 'scheduled';

  @override
  String get selectDate => 'Select date';

  @override
  String get noMoreTripsToday => 'No more trips today';

  @override
  String get noTripsFound => 'No trips found';

  @override
  String get errorLoadingTrips => 'Unable to load trips';

  @override
  String get onTime => 'on time';

  @override
  String get delayed => 'delayed';

  @override
  String get arriving => 'arriving';

  @override
  String get unknownRoute => 'Unknown route';
}
