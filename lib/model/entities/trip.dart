import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

@JsonSerializable()
class Trip {
  final String id;

  @JsonKey(name: 'trip_headsign')
  final String? headsign;

  @JsonKey(name: 'route_short_name')
  final String? routeShortName;

  @JsonKey(name: 'route_color')
  final String? routeColor;

  @JsonKey(name: 'route_text_color')
  final String? routeTextColor;

  @JsonKey(name: 'estimated_arrival_time')
  final String? estimatedArrivalTime;

  @JsonKey(name: 'scheduled_arrival_time')
  final String? scheduledArrivalTime;

  @JsonKey(name: 'delay_minutes')
  final double? delay;

  @JsonKey(name: 'arrival_minutes')
  final double? arrivalMinutes;

  const Trip({
    required this.id,
    this.routeShortName,
    this.headsign,
    this.routeColor,
    this.routeTextColor,
    this.estimatedArrivalTime,
    this.scheduledArrivalTime,
    this.delay,
    this.arrivalMinutes,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? json['trip_id'];

    final modifiedJson = Map<String, dynamic>.from(json);
    modifiedJson['id'] = id;

    return _$TripFromJson(modifiedJson);
  }

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
