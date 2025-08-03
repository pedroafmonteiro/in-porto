import 'package:flutter/material.dart';
import 'package:in_porto/view/navigation/navigation_view.dart';
import 'package:in_porto/viewmodel/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome!'),
            Text('Discover a new way to explore Porto.'),
            ElevatedButton(
              onPressed: () {
                context.read<SettingsViewModel>().setHasSeenOnboarding(1);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const NavigationView(),
                  ),
                );
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
