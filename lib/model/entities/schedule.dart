import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  @JsonKey(name: 'stop_id')
  final String stopId;

  @JsonKey(name: 'route_id')
  final String routeId;

  @JsonKey(name: 'direction_id')
  final String? directionId;

  @JsonKey(name: 'service_id')
  final String serviceId;

  @JsonKey(name: 'arrival_time')
  final String arrivalTime;

  Schedule({
    required this.stopId,
    required this.routeId,
    required this.directionId,
    required this.serviceId,
    required this.arrivalTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
