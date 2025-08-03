import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/view/settings/widgets/appearance_settings_view.dart';
import 'package:in_porto/view/settings/widgets/language_settings_view.dart';
import 'package:in_porto/view/settings/widgets/licenses_view.dart';
import 'package:in_porto/view/common/transitions.dart';
import 'package:in_porto/view/settings/widgets/public_transportation_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.settingsTitle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    title: Text(AppLocalizations.of(context)!.appearanceTitle),
                    leading: Icon(Icons.palette_rounded),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        buildSharedAxisPageRoute(
                          page: const AppearanceSettingsView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    title: Text(AppLocalizations.of(context)!.languageTitle),
                    leading: Icon(Icons.language_rounded),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        buildSharedAxisPageRoute(
                          page: const LanguageSettingsView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.publicTransportationTitle,
                    ),
                    leading: Icon(Icons.directions_bus_rounded),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        buildSharedAxisPageRoute(
                          page: const PublicTransportationView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.openSourceLicensesTitle,
                    ),
                    leading: Icon(Icons.copyright_rounded),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        buildSharedAxisPageRoute(
                          page: const LicensesView(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 16.0,
            ),
            child: Text(
              AppLocalizations.of(context)!.supportMessage,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
