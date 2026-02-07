import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopDetails extends ConsumerWidget {
  final Stop stop;

  const StopDetails({super.key, required this.stop});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSchedules = ref.watch(stopSchedulesProvider(stop));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          stop.name ?? 'Unknown stop',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: asyncSchedules.when(
        data: (schedules) {
          if (schedules.isEmpty) {
            return const Center(child: Text('No schedules found'));
          }
          return ListView.builder(
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              return ListTile(
                title: Text('Route: ${schedule.routeId}'),
                subtitle: Text('Arrival time: ${schedule.arrivalTime}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
