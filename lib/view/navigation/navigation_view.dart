import 'package:flutter/material.dart';
import 'package:in_porto/view/navigation/widgets/action_center.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ActionCenter(),
    );
  }
}
