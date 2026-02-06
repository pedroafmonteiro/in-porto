import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopDebugView extends ConsumerStatefulWidget {
  const StopDebugView({super.key});

  @override
  ConsumerState<StopDebugView> createState() => _StopDebugViewState();
}

class _StopDebugViewState extends ConsumerState<StopDebugView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final stopsAsync = ref.watch(stopViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('STCP Stop Debugger')),
      body: stopsAsync.when(
        data: (stops) => ListView.builder(
          controller: scrollController,
          itemCount: stops.length + 1,
          itemBuilder: (context, index) {
            if (index == stops.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final stop = stops[index];
            return ListTile(
              title: Text(stop.name ?? 'Unknown'),
              subtitle: Text(
                'ID: ${stop.id} | Lat: ${stop.latitude ?? 'N/A'} | Lon: ${stop.longitude ?? 'N/A'}',
              ),
              trailing: const Icon(Icons.bug_report_outlined),
              onTap: () => _showStopDetails(context, stop.id),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  void _showStopDetails(BuildContext context, String stopId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) =>
            StopDetailContent(stopId: stopId),
      ),
    );
  }
}

class StopDetailContent extends ConsumerWidget {
  final String stopId;
  const StopDetailContent({super.key, required this.stopId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopDetailsAsync = ref.watch(stopDetailsProvider(stopId));

    return stopDetailsAsync.when(
      data: (stop) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stop.name ?? 'Unknown',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Text(
                'Available Routes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: (stop.routes ?? [])
                      .map(
                        (r) => ListTile(
                          leading: CircleAvatar(
                            backgroundColor: r.color != null
                                ? Color(
                                    int.parse(
                                      r.color!.replaceFirst('#', '0xFF'),
                                    ),
                                  )
                                : Colors.grey,
                          ),
                          title: Text('${r.number} - ${r.name}'),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading stop details',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text('$error', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
