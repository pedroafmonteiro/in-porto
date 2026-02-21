import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class RouteDebugView extends ConsumerStatefulWidget {
  const RouteDebugView({super.key});

  @override
  ConsumerState<RouteDebugView> createState() => _RouteDebugViewState();
}

class _RouteDebugViewState extends ConsumerState<RouteDebugView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final routesAsync = ref.watch(routeViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('STCP Route Debugger')),
      body: routesAsync.when(
        data: (routes) => ListView.builder(
          controller: scrollController,
          itemCount: routes.length,
          itemBuilder: (context, index) {
            final route = routes[index];
            return ListTile(
              title: Text(route.displayName ?? 'Unknown'),
              subtitle: Text(
                'ID: ${route.id} | Short Name: ${route.shortName ?? 'N/A'}',
              ),
              trailing: const Icon(Icons.bug_report_outlined),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => RouteDetailContent(route: route),
                );
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class RouteDetailContent extends ConsumerWidget {
  const RouteDetailContent({super.key, required this.route});

  final TransportRoute route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Route Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('ID: ${route.id}'),
          Text(
            'Stop ID: ${route.stopIds.isNotEmpty ? route.stopIds.join(', ') : 'N/A'}',
          ),
          Text('Direction ID: ${route.directionId ?? 'N/A'}'),
          Text('Short Name: ${route.shortName ?? 'N/A'}'),
          Text('Long Name: ${route.longName ?? 'N/A'}'),
          Text('Display Name: ${route.displayName ?? 'N/A'}'),
          Text('Direction Name: ${route.directionName ?? 'N/A'}'),
          Text('Trip Headsign: ${route.tripHeadsign ?? 'N/A'}'),
          Text('Color: ${route.color ?? 'N/A'}'),
          Text('Text Color: ${route.textColor ?? 'N/A'}'),
        ],
      ),
    );
  }
}
