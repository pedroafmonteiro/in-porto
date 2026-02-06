import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopDetails extends ConsumerWidget {
  final String stopId;

  const StopDetails({super.key, required this.stopId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStop = ref.watch(stopDetailsProvider(stopId));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: asyncStop.when(
          data: (stop) => Text(stop.name ?? 'Stop'),
          loading: () => const Text('Loading...'),
          error: (e, st) => const Text('Unknown stop'),
        ),
      ),
      body: Center(
        child: asyncStop.when(
          data: (stop) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              stop.name ?? 'No name available',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (e, st) => const Text('Failed to load stop'),
        ),
      ),
    );
  }
}
