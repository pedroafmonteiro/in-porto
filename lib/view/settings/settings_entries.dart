import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/view/settings/pages/appearance_settings_view.dart';
import 'package:in_porto/view/settings/pages/language_settings_view.dart';
import 'package:in_porto/view/settings/pages/licenses_view.dart';
import 'package:in_porto/view/settings/pages/route_debug_view.dart';
import 'package:in_porto/view/settings/pages/stop_debug_view.dart';

class SettingsEntries {
  final String title;
  final Icon leadingIcon;
  final Widget page;

  SettingsEntries({
    required this.title,
    required this.leadingIcon,
    required this.page,
  });

  static List<SettingsEntries> entries(BuildContext context) {
    return [
      SettingsEntries(
        title: AppLocalizations.of(context)!.appearanceTitle,
        leadingIcon: Icon(Icons.palette_rounded),
        page: AppearanceSettingsView(),
      ),
      SettingsEntries(
        title: AppLocalizations.of(context)!.languageTitle,
        leadingIcon: Icon(Icons.language_rounded),
        page: LanguageSettingsView(),
      ),
      SettingsEntries(
        title: AppLocalizations.of(context)!.openSourceLicensesTitle,
        leadingIcon: Icon(Icons.article_rounded),
        page: LicensesView(),
      ),
      SettingsEntries(
        title: 'STCP Stops',
        leadingIcon: Icon(Icons.directions_bus_rounded),
        page: StopDebugView(),
      ),
      SettingsEntries(
        title: 'STCP Routes',
        leadingIcon: Icon(Icons.route_rounded),
        page: RouteDebugView(),
      ),
    ];
  }
}
