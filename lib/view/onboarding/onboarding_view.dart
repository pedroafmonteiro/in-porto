import 'package:flutter/material.dart';
import 'package:in_porto/view/onboarding/widgets/onboarding_container.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0.0, -0.75),
              child: Image.asset(
                'assets/images/onboarding.png',
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: OnboardingContainer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
