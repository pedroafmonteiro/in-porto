import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/view/stops/widgets/departure_card.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopOverviewDepartures extends ConsumerWidget {
  const StopOverviewDepartures({
    super.key,
    required this.stop,
  });

  final Stop stop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(nowProvider, (_, _) {
      ref.invalidate(stopRealtimeTripsProvider(stop));
    });

    final asyncDepartures = ref.watch(stopDeparturesProvider(stop));
    final realtimeLastUpdated = ref
        .watch(stopRealtimeTripsProvider(stop))
        .value
        ?.$1;

    return asyncDepartures.maybeWhen(
      skipLoadingOnRefresh: true,
      data: (departures) {
        if (departures.isEmpty) {
          return _buildEmptyState(context);
        }

        return Column(
          spacing: 8.0,
          children: [
            ...departures.map(
              (info) => DepartureCard(departure: info),
            ),
            Text(
              '${AppLocalizations.of(context)!.lastUpdated} ${realtimeLastUpdated != null ? '${TimeOfDay.fromDateTime(realtimeLastUpdated).format(context)}:${realtimeLastUpdated.second.toString().padLeft(2, '0')}' : 'N/A'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
      loading: () {
        if (asyncDepartures.hasValue) {
          final departures = asyncDepartures.value!;
          if (departures.isEmpty) return _buildEmptyState(context);
          return Column(
            spacing: 8.0,
            children: [
              ...departures.map(
                (info) => DepartureCard(departure: info),
              ),
              Text(
                '${AppLocalizations.of(context)!.lastUpdated} ${realtimeLastUpdated != null ? '${TimeOfDay.fromDateTime(realtimeLastUpdated).format(context)}:${realtimeLastUpdated.second.toString().padLeft(2, '0')}' : 'N/A'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        }
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          alignment: Alignment.center,
          child: ExpressiveLoadingIndicator(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
      },
      orElse: () => _buildErrorState(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 48),
          const SizedBox(height: 8),
          Text(
            'No upcoming trips.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 8),
          Text(
            'Unable to load trips.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
