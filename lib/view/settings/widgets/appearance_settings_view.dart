import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/viewmodel/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class AppearanceSettingsView extends StatelessWidget {
  const AppearanceSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(AppLocalizations.of(context)!.appearanceTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Text(AppLocalizations.of(context)!.lightMode),
              leading: Icon(Icons.light_mode),
              trailing:
                  context.watch<SettingsViewModel>().settings.appearance ==
                      "light"
                  ? Icon(Icons.check_rounded)
                  : null,
              onTap: () {
                context.read<SettingsViewModel>().setAppearance("light");
              },
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Text(AppLocalizations.of(context)!.darkMode),
              leading: Icon(Icons.dark_mode),
              trailing:
                  context.watch<SettingsViewModel>().settings.appearance ==
                      "dark"
                  ? Icon(Icons.check_rounded)
                  : null,
              onTap: () {
                context.read<SettingsViewModel>().setAppearance("dark");
              },
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Text(AppLocalizations.of(context)!.systemMode),
              leading: Icon(Icons.brightness_6_rounded),
              trailing:
                  context.watch<SettingsViewModel>().settings.appearance ==
                      "system"
                  ? Icon(Icons.check_rounded)
                  : null,
              onTap: () {
                context.read<SettingsViewModel>().setAppearance("system");
              },
            ),
          ),
        ],
      ),
    );
  }
}
