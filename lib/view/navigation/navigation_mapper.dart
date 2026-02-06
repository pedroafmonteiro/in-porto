import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/navigation.dart';
import 'package:in_porto/view/navigation/widgets/action_center.dart';
import 'package:in_porto/view/navigation/widgets/base_action_center.dart';
import 'package:in_porto/view/search/search_view.dart';
import 'package:in_porto/view/stops/stop_details.dart';
import 'package:in_porto/view/stops/stop_overview.dart';

extension NavigationOverrideMapper on NavigationOverride? {
  ActionCenterOverride buildActionCenterOverride() {
    return switch (this) {
      null => ActionCenterOverride(
          key: 'base',
          closedBuilder: (context, {required onOpen, onClose, required onSelected}) =>
              BaseActionCenter(
            onSelected: onSelected,
            onOpen: onOpen,
            onClose: onClose,
          ),
          initialOpenBuilder: (context) => const SearchView(),
        ),
      Stop stop => ActionCenterOverride(
          key: stop.id,
          closedBuilder: (context, {required onOpen, onClose, required onSelected}) =>
              StopOverview(
            stopId: stop.id,
            stopName: stop.name ?? 'Stop',
            onOpen: onOpen,
            onClose: onClose,
            onSelected: onSelected,
          ),
          initialOpenBuilder: (context) => StopDetails(
            stopId: stop.id,
          ),
        ),
      _ => throw UnimplementedError('No override for $this'),
    };
  }
}
