import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopDetails extends ConsumerWidget {
  final Stop stop;

  const StopDetails({super.key, required this.stop});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRoutes = ref.watch(stopRoutesProvider(stop));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: asyncRoutes.when(
          data: (routes) =>
              Text(routes.isNotEmpty ? routes.first.displayName ?? 'Stop' : 'Stop'),
          loading: () => const Text('Loading...'),
          error: (e, st) => const Text('Unknown stop'),
        ),
      ),
      body: Center(
        child: asyncRoutes.when(
          data: (routes) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              routes.isNotEmpty
                  ? routes.first.displayName ?? 'No name available'
                  : 'No name available',
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
