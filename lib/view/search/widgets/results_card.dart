import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/search/searchable_item.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';

class ResultsCard extends ConsumerWidget {
  const ResultsCard({super.key, required this.result});

  final SearchResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.0),
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        leading: _buildResultIcon(result),
        onTap: () => _handleResultTap(context, ref, result),
        title: Text(
          result.title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: result.subtitle != null
            ? Text(
                result.subtitle!,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              )
            : null,
      ),
    );
  }

  Widget _buildResultIcon(SearchResult result) {
    switch (result.type) {
      case SearchResultType.stop:
        return const Icon(Icons.location_on_rounded);
      case SearchResultType.route:
        final route = result.source as TransportRoute;
        return RouteBadge(
          number: route.shortName,
          color: route.color,
          textColor: route.textColor,
        );
    }
  }

  void _handleResultTap(
    BuildContext context,
    WidgetRef ref,
    SearchResult result,
  ) {
    if (result.type == SearchResultType.stop) {
      final stop = result.source as Stop;
      Navigator.of(context).pop();
      ref
          .read(selectedNavigationOverrideProvider.notifier)
          .select(stop, delayed: true);
    } else if (result.type == SearchResultType.route) {
      final route = result.source as TransportRoute;
      Navigator.of(context).pop();
      ref
          .read(selectedNavigationOverrideProvider.notifier)
          .select(route, delayed: true);
    }
  }
}
