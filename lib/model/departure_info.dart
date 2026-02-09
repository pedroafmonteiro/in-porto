import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';

class DepartureInfo {
  final TransportRoute route;
  final Schedule? schedule;
  final DateTime departureTime;
  final bool isRealtime;
  final double? realtimeMinutes;
  final String? headsignOverride;
  final String? status;

  DepartureInfo({
    required this.route,
    this.schedule,
    required this.departureTime,
    this.isRealtime = false,
    this.realtimeMinutes,
    this.headsignOverride,
    this.status,
  });
}
