import 'package:flutter/material.dart';
import 'package:in_porto/model/entities/stop.dart';

class StopDetailsAppBarTitle extends StatelessWidget {
  const StopDetailsAppBarTitle({super.key, required this.stop});

  final Stop stop;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stop.name ?? 'Unknown Stop',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (stop.code != null)
          Text(
            '${stop.code}',
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
