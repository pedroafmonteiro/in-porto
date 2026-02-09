import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/view/stops/widgets/stop_overview_departures.dart';
import 'package:in_porto/view/stops/widgets/stop_overview_header.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopOverview extends ConsumerWidget {
  final VoidCallback onOpen;
  final VoidCallback? onClose;
  final ValueChanged<Widget> onSelected;
  final Stop stop;

  const StopOverview({
    super.key,
    required this.onOpen,
    this.onClose,
    required this.onSelected,
    required this.stop,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRoutes = ref.watch(stopRoutesProvider(stop));
    final asyncSchedules = ref.watch(stopSchedulesProvider(stop, null));
    final totalMaxHeight = MediaQuery.of(context).size.height * 0.5;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: totalMaxHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,
        children: [
          StopOverviewHeader(
            stop: stop,
            asyncRoutes: asyncRoutes.value ?? [],
            onOpen: onOpen,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: StopOverviewDepartures(
                stop: stop,
                asyncRoutes: asyncRoutes,
                asyncSchedules: asyncSchedules,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
