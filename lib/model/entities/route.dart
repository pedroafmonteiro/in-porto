import 'package:in_porto/model/navigation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route.g.dart';

@JsonSerializable()
class TransportRoute implements NavigationOverride {
  @JsonKey(name: 'route_id')
  final String id;

  @JsonKey(name: 'direction_id')
  final int? directionId;

  @JsonKey(name: 'route_short_name')
  final String? shortName;

  @JsonKey(name: 'route_long_name')
  final String? longName;

  @JsonKey(name: 'display_name')
  final String? displayName;

  @JsonKey(name: 'direction_name')
  final String? directionName;

  @JsonKey(name: 'trip_headsign')
  final String? tripHeadsign;

  @JsonKey(name: 'route_color')
  final String? color;

  @JsonKey(name: 'route_text_color')
  final String? textColor;

  final List<String?> stopIds;

  const TransportRoute({
    required this.id,
    this.shortName,
    this.longName,
    this.displayName,
    this.directionName,
    this.tripHeadsign,
    this.directionId,
    this.color,
    this.textColor,
    this.stopIds = const [],
  });

  factory TransportRoute.fromJson(Map<String, dynamic> json) =>
      _$TransportRouteFromJson(json);

  Map<String, dynamic> toJson() => _$TransportRouteToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportRoute &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          directionId == other.directionId;

  @override
  int get hashCode => Object.hash(id, directionId);

  TransportRoute copyWith({
    String? id,
    int? directionId,
    String? shortName,
    String? longName,
    String? displayName,
    String? directionName,
    String? tripHeadsign,
    String? color,
    String? textColor,
    List<String?>? stopIds,
  }) {
    return TransportRoute(
      id: id ?? this.id,
      directionId: directionId ?? this.directionId,
      shortName: shortName ?? this.shortName,
      longName: longName ?? this.longName,
      displayName: displayName ?? this.displayName,
      directionName: directionName ?? this.directionName,
      tripHeadsign: tripHeadsign ?? this.tripHeadsign,
      color: color ?? this.color,
      textColor: textColor ?? this.textColor,
      stopIds: stopIds ?? this.stopIds,
    );
  }
}
