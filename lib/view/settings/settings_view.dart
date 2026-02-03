import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/view/settings/pages/appearance_settings_view.dart';
import 'package:in_porto/view/settings/pages/debug_view.dart';
import 'package:in_porto/view/settings/pages/language_settings_view.dart';
import 'package:in_porto/view/settings/pages/licenses_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (kDebugMode)
            IconButton(
              icon: Icon(Icons.developer_mode_rounded),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DebugView(),
                  ),
                );
              },
            ),
        ],
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
                  child: ListTile(
                    title: Text(AppLocalizations.of(context)!.appearanceTitle),
                    leading: Icon(Icons.palette_rounded),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AppearanceSettingsView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(AppLocalizations.of(context)!.languageTitle),
                    leading: Icon(Icons.language_rounded),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LanguageSettingsView(),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context)!.openSourceLicensesTitle,
                    ),
                    leading: Icon(Icons.copyright_rounded),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LicensesView(),
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
