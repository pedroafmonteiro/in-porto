import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/view/routes/widgets/route_details_header.dart';
import 'package:in_porto/view/routes/widgets/route_details_stops.dart';

class RouteDetails extends ConsumerWidget {
  final VoidCallback onOpen;
  final VoidCallback? onClose;
  final ValueChanged<Widget> onSelected;
  final TransportRoute route;

  const RouteDetails({
    super.key,
    required this.onOpen,
    required this.onClose,
    required this.onSelected,
    required this.route,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalMaxHeight = MediaQuery.of(context).size.height * 0.5;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: totalMaxHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.0,
        children: [
          RouteDetailsHeader(route: route),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: RouteDetailsStops(route: route),
            )
          ),
        ],
      ),
    );
  }
}
