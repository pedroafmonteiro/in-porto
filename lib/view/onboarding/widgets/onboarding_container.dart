import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/view/common/buttons.dart';
import 'package:in_porto/view/common/transitions.dart';
import 'package:in_porto/view/onboarding/pages/download_data_view.dart';

class OnboardingContainer extends StatelessWidget {
  const OnboardingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.appDescription,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 100),
            MainButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  buildSharedAxisPageRoute(
                    page: const DownloadDataView(),
                  ),
                );
              },
              text: AppLocalizations.of(context)!.getStarted,
              icon: Icons.arrow_forward_ios_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
