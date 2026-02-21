import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/navigation.dart';
import 'package:in_porto/view/navigation/widgets/action_center.dart';
import 'package:in_porto/view/navigation/widgets/base_action_center.dart';
import 'package:in_porto/view/search/search_view.dart';
import 'package:in_porto/view/stops/stop_details.dart';
import 'package:in_porto/view/stops/stop_overview.dart';
import 'package:in_porto/view/routes/route_details.dart';

extension NavigationOverrideMapper on NavigationOverride? {
  ActionCenterOverride buildActionCenterOverride() {
    return switch (this) {
      null => ActionCenterOverride(
        key: 'base',
        closedBuilder:
            (context, {required onOpen, onClose, required onSelected}) =>
                BaseActionCenter(
                  onSelected: onSelected,
                  onOpen: onOpen,
                  onClose: onClose,
                ),
        initialOpenBuilder: (context) => const SearchView(),
      ),
      Stop stop => ActionCenterOverride(
        key: stop.id,
        closedBuilder:
            (context, {required onOpen, onClose, required onSelected}) =>
                StopOverview(
                  stop: stop,
                  onOpen: onOpen,
                  onClose: onClose,
                  onSelected: onSelected,
                ),
        initialOpenBuilder: (context) => StopDetails(
          stop: stop,
        ),
      ),
      TransportRoute route => ActionCenterOverride(
        key: route.id,
        closedBuilder:
            (context, {required onOpen, onClose, required onSelected}) =>
                RouteDetails(
                  route: route,
                  onOpen: onOpen,
                  onClose: onClose,
                  onSelected: onSelected,
                ),
        initialOpenBuilder: (context) => RouteDetails(
          route: route,
          onOpen: () {},
          onClose: () {},
          onSelected: (_) {},
        ),
      ),
      _ => throw UnimplementedError('No override for $this'),
    };
  }
}
