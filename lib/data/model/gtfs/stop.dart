import 'package:objectbox/objectbox.dart';

@Entity()
class Stop {
  @Id()
  int id = 0;

  @Index()
  final String stopId;

  @Index()
  final String? agencyId;

  final String? code;

  final String? name;

  final String? ttsName;

  final String? description;

  final double? latitude;

  final double? longitude;

  final String? zoneId;

  final String? url;

  final int? locationType;

  final String? parentStation;

  final String? timezone;

  final int? wheelchairBoarding;

  final String? levelId;

  final String? platformCode;

  Stop({
    this.id = 0,
    required this.stopId,
    this.agencyId,
    this.code,
    this.name,
    this.ttsName,
    this.description,
    this.latitude,
    this.longitude,
    this.zoneId,
    this.url,
    this.locationType,
    this.parentStation,
    this.timezone,
    this.wheelchairBoarding,
    this.levelId,
    this.platformCode,
  }) : assert(stopId.isNotEmpty, 'Stop id cannot be empty'),
       assert(
         url == null ||
             url.isEmpty ||
             url.startsWith('http://') ||
             url.startsWith('https://'),
         'Stop url must be a valid URL',
       ),
       assert(
         locationType == null || (locationType >= 0 && locationType <= 4),
         'locationType must be between 0 and 4',
       ),
       assert(
         wheelchairBoarding == null ||
             (wheelchairBoarding >= 0 && wheelchairBoarding <= 2),
         'wheelchairBoarding must be 0, 1, or 2',
       );

  factory Stop.fromMap(Map<String, dynamic> map) {
    return Stop(
      stopId: map['stop_id']?.toString() ?? '',
      agencyId: map['agency_id']?.toString(),
      code: map['stop_code']?.toString(),
      name: map['stop_name']?.toString(),
      ttsName: map['tts_stop_name']?.toString(),
      description: map['stop_desc']?.toString(),
      latitude: double.tryParse(map['stop_lat']?.toString() ?? ''),
      longitude: double.tryParse(map['stop_lon']?.toString() ?? ''),
      zoneId: map['zone_id']?.toString(),
      url: map['stop_url']?.toString(),
      locationType: int.tryParse(map['location_type']?.toString() ?? ''),
      parentStation: map['parent_station']?.toString(),
      timezone: map['stop_timezone']?.toString(),
      wheelchairBoarding: int.tryParse(
        map['wheelchair_boarding']?.toString() ?? '',
      ),
      levelId: map['level_id']?.toString(),
      platformCode: map['platform_code']?.toString(),
    );
  }

  @override
  String toString() {
    return 'Stop(stopId: $stopId, code: $code, name: $name, ttsName: $ttsName, description: $description, latitude: $latitude, longitude: $longitude, zoneId: $zoneId, url: $url, locationType: $locationType, parentStation: $parentStation, timezone: $timezone, wheelchairBoarding: $wheelchairBoarding, levelId: $levelId, platformCode: $platformCode)';
  }
}
