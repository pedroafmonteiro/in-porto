import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/view/common/transitions.dart';
import 'package:in_porto/view/onboarding/onboarding_view.dart';
import 'package:in_porto/viewmodel/data_viewmodel.dart';
import 'package:in_porto/viewmodel/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class DebugView extends StatelessWidget {
  const DebugView({super.key});

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
        title: Text(AppLocalizations.of(context)!.debugSettingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              title: Text(AppLocalizations.of(context)!.resetOnboarding),
              leading: Icon(Icons.refresh_rounded),
              onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainer,
                    title: Text(
                      AppLocalizations.of(context)!.resetOnboarding,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.resetOnboardingText1,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          AppLocalizations.of(context)!.resetOnboardingText2,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          context
                              .read<SettingsViewModel>()
                              .setHasSeenOnboarding(0);
                          await context
                              .read<DataViewModel>()
                              .deleteAllGtfsData();
                          if (context.mounted) {
                            Navigator.of(context).pushReplacement(
                              buildSharedAxisPageRoute(
                                page: const OnboardingView(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.yes,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.no,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
