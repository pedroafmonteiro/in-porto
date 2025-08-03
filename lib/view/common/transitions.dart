import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

PageRouteBuilder<T> buildSharedAxisPageRoute<T>({
  required Widget page,
  SharedAxisTransitionType transitionType = SharedAxisTransitionType.horizontal,
  Duration transitionDuration = const Duration(milliseconds: 500),
}) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: transitionDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      );
    },
  );
}