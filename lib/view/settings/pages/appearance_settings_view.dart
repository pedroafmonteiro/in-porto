import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/viewmodel/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class AppearanceSettingsView extends StatelessWidget {
  const AppearanceSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.system),
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
          Card(
            child: ListTile(
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
            child: ListTile(
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
        ],
      ),
    );
  }
}
