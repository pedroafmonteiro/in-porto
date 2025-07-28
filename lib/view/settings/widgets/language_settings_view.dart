import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/viewmodel/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class LanguageSettingsView extends StatelessWidget {
  const LanguageSettingsView({super.key});

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
        title: Text(AppLocalizations.of(context)!.languageTitle),
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
              title: Text(AppLocalizations.of(context)!.system),
              leading: Icon(Icons.language_rounded),
              trailing:
                  context.watch<SettingsViewModel>().settings.language ==
                      "system"
                  ? Icon(Icons.check_rounded)
                  : null,
              onTap: () {
                context.read<SettingsViewModel>().setLanguage("system");
              },
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Text(AppLocalizations.of(context)!.portuguese),
              leading: Text("🇵🇹", style: TextStyle(fontSize: 16)),
              trailing:
                  context.watch<SettingsViewModel>().settings.language == "pt"
                  ? Icon(Icons.check_rounded)
                  : null,
              onTap: () {
                context.read<SettingsViewModel>().setLanguage("pt");
              },
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Text(AppLocalizations.of(context)!.english),
              leading: Text("🇬🇧", style: TextStyle(fontSize: 16)),
              trailing:
                  context.watch<SettingsViewModel>().settings.language == "en"
                  ? Icon(Icons.check_rounded)
                  : null,
              onTap: () {
                context.read<SettingsViewModel>().setLanguage("en");
              },
            ),
          ),
        ],
      ),
    );
  }
}
