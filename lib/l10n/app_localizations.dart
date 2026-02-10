import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'In Porto.'**
  String get appTitle;

  /// A short description of the application
  ///
  /// In en, this message translates to:
  /// **'Explore Porto like never before.'**
  String get appDescription;

  /// Button text to start using the app
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Title for the download data section
  ///
  /// In en, this message translates to:
  /// **'Download Data'**
  String get downloadDataTitle;

  /// Text explaining the need to download data
  ///
  /// In en, this message translates to:
  /// **'To use this app, you will need to connect to the internet at least once to download essential information from the cloud.'**
  String get downloadDataText1;

  /// Text explaining the nature of the data being downloaded
  ///
  /// In en, this message translates to:
  /// **'All data is publicly available and relates to the city of Porto. No private information or analytics are collected that could identify you.'**
  String get downloadDataText2;

  /// Text explaining the duration of the download process
  ///
  /// In en, this message translates to:
  /// **'This process may take a few minutes, depending on your internet connection and the amount of data being downloaded.'**
  String get downloadDataText3;

  /// Text warning against closing the app during download
  ///
  /// In en, this message translates to:
  /// **'Do not close the app or turn off your device during this process.'**
  String get downloadDataText4;

  /// Button text to continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// Button text to finish the onboarding process
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishText;

  /// Message shown when the app successfully connects to the internet
  ///
  /// In en, this message translates to:
  /// **'Connected to the internet.'**
  String get connectivitySuccess;

  /// Message shown when the app fails to connect to the internet
  ///
  /// In en, this message translates to:
  /// **'No internet connection.'**
  String get connectivityError;

  /// Title for the settings page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Title for the system mode setting
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Title for the appearance settings
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// Title for the light mode setting
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightMode;

  /// Title for the dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkMode;

  /// Title for the language settings
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// Title for the Portuguese language option
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// Title for the English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Title for the public transportation settings
  ///
  /// In en, this message translates to:
  /// **'Public Transportation'**
  String get publicTransportationTitle;

  /// Title for the Metro do Porto public transportation option
  ///
  /// In en, this message translates to:
  /// **'Metro do Porto'**
  String get metrodoporto;

  /// Title for the STCP public transportation option
  ///
  /// In en, this message translates to:
  /// **'STCP'**
  String get stcp;

  /// Title for the STCP public transportation option
  ///
  /// In en, this message translates to:
  /// **'Sociedade de Transportes Coletivos do Porto'**
  String get stcpFull;

  /// Title for the CP public transportation option
  ///
  /// In en, this message translates to:
  /// **'CP'**
  String get cp;

  /// Title for the Comboios de Portugal public transportation option
  ///
  /// In en, this message translates to:
  /// **'Comboios de Portugal'**
  String get cpFull;

  /// Title for the open source licenses
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get openSourceLicensesTitle;

  /// A single license
  ///
  /// In en, this message translates to:
  /// **'license'**
  String get license;

  /// Message to show support for the project
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ in Porto'**
  String get supportMessage;

  /// Title for the debug settings page
  ///
  /// In en, this message translates to:
  /// **'Debug Settings'**
  String get debugSettingsTitle;

  /// Button to reset the onboarding process
  ///
  /// In en, this message translates to:
  /// **'Reset Onboarding'**
  String get resetOnboarding;

  /// Text asking for confirmation to reset the onboarding process
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the onboarding process?'**
  String get resetOnboardingText1;

  /// Text explaining the consequences of resetting the onboarding process
  ///
  /// In en, this message translates to:
  /// **'This will remove all GTFS data.'**
  String get resetOnboardingText2;

  /// Button text to confirm an action
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// Button text to cancel an action
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Placeholder text for the search input
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Label for the button to select today's date
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Label for the button to select tomorrow's date
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// Label for the button to select yesterday's date
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Label for the button to show older departures
  ///
  /// In en, this message translates to:
  /// **'See older departures from today'**
  String get olderDepartures;

  /// Button text to indicate completion of an action
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Label to indicate that a transportation departure is happening now
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// Label to indicate that a transportation departure info is live/realtime
  ///
  /// In en, this message translates to:
  /// **'Realtime'**
  String get realtime;

  /// Label to indicate that a transportation departure is scheduled for a future time
  ///
  /// In en, this message translates to:
  /// **'scheduled'**
  String get scheduled;

  /// Label for the button to open the date picker
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// Message shown when there are no more future departures for the current day
  ///
  /// In en, this message translates to:
  /// **'No more trips today'**
  String get noMoreTripsToday;

  /// Message shown when no trips are found for a selected date
  ///
  /// In en, this message translates to:
  /// **'No trips found'**
  String get noTripsFound;

  /// Message shown when there is an error loading trips
  ///
  /// In en, this message translates to:
  /// **'Unable to load trips'**
  String get errorLoadingTrips;

  /// Label to indicate that a transportation departure is on time
  ///
  /// In en, this message translates to:
  /// **'on time'**
  String get onTime;

  /// Label to indicate that a transportation departure is delayed
  ///
  /// In en, this message translates to:
  /// **'delayed'**
  String get delayed;

  /// Label to indicate that a transportation departure is arriving at the stop
  ///
  /// In en, this message translates to:
  /// **'arriving'**
  String get arriving;

  /// Label to indicate that the route of a transportation departure is unknown
  ///
  /// In en, this message translates to:
  /// **'Unknown route'**
  String get unknownRoute;

  /// Label for the section showing upcoming departures
  ///
  /// In en, this message translates to:
  /// **'Upcoming departures'**
  String get upcomingDepartures;

  /// Message shown when the user denies location permission
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get locationPermissionDenied;

  /// Message shown when the user denies location permission, explaining how to enable it
  ///
  /// In en, this message translates to:
  /// **'To show nearby stops, please allow location access.'**
  String get locationPermissionDeniedDescription;

  /// Message shown when the user permanently denies location permission
  ///
  /// In en, this message translates to:
  /// **'Location permission permanently denied'**
  String get locationPermissionDeniedForever;

  /// Message shown when the user permanently denies location permission, explaining how to enable it
  ///
  /// In en, this message translates to:
  /// **'To show nearby stops, please enable location access in your device settings.'**
  String get locationPermissionDeniedForeverDescription;

  /// Message shown when the user needs to grant precise location permission
  ///
  /// In en, this message translates to:
  /// **'Precise location permission needed'**
  String get preciseLocationNeeded;

  /// Message shown when the user needs to grant precise location permission, explaining how to enable it
  ///
  /// In en, this message translates to:
  /// **'To show your exact position on the map, please grant precise location access.'**
  String get preciseLocationNeededDescription;

  /// Button text to cancel an action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button text to open the app settings
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// Button text to grant a permission
  ///
  /// In en, this message translates to:
  /// **'Grant'**
  String get grant;

  /// Button text to try granting a permission again
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// Label to indicate the last time the realtime data was updated. The {time} placeholder will be replaced with the actual time.
  ///
  /// In en, this message translates to:
  /// **'Last updated: '**
  String get lastUpdated;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
