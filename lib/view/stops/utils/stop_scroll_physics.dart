import 'package:flutter/material.dart';

class StopScrollPhysics extends BouncingScrollPhysics {
  const StopScrollPhysics({super.parent, this.snapAtOrigin = true});

  final bool snapAtOrigin;

  @override
  StopScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return StopScrollPhysics(
      parent: buildParent(ancestor),
      snapAtOrigin: snapAtOrigin,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    if (!snapAtOrigin) {
      return super.createBallisticSimulation(position, velocity);
    }

    final Simulation? simulation = super.createBallisticSimulation(
      position,
      velocity,
    );

    if (velocity < 0.0 && position.pixels > 0.0) {
      if (simulation != null && simulation.x(double.infinity) < 0.0) {
        return ScrollSpringSimulation(spring, position.pixels, 0.0, velocity);
      }
    } else if (velocity > 0.0 && position.pixels < 0.0) {
      if (simulation != null && simulation.x(double.infinity) > 0.0) {
        return ScrollSpringSimulation(spring, position.pixels, 0.0, velocity);
      }
    }

    return simulation;
  }
}
