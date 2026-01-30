import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisBackTransitionsBuilder extends PageTransitionsBuilder {
  const SharedAxisBackTransitionsBuilder({
    this.transitionType = SharedAxisTransitionType.horizontal,
  });

  final SharedAxisTransitionType transitionType;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: transitionType,
      child: child,
    );
  }
}
