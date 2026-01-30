class Stop {
  /// Unique ID for the stop/platform/station/entrance/boarding area (required)
  final String id;

  /// Short code for the stop (optional)
  final String? code;

  /// Name of the location (conditionally required)
  final String? name;

  /// Text-to-speech stop name (optional)
  final String? ttsName;

  /// Description of the location (optional)
  final String? description;

  /// Latitude (conditionally required)
  final double? latitude;

  /// Longitude (conditionally required)
  final double? longitude;

  /// Fare zone ID (optional)
  final String? zoneId;

  /// URL of a web page about the location (optional)
  final String? url;

  /// Location type (optional, 0-4)
  final int? locationType;

  /// Parent station ID (conditionally required)
  final String? parentStation;

  /// Timezone of the location (optional)
  final String? timezone;

  /// Wheelchair boarding info (optional, 0-2)
  final int? wheelchairBoarding;

  /// Level ID (optional)
  final String? levelId;

  /// Platform code (optional)
  final String? platformCode;

  Stop({
    required this.id,
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
  }) : assert(id.isNotEmpty, 'Stop id cannot be empty'),
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
      id: map['stop_id'] as String,
      code: map['stop_code'] as String?,
      name: map['stop_name'] as String?,
      ttsName: map['tts_stop_name'] as String?,
      description: map['stop_desc'] as String?,
      latitude: map['stop_lat'] != null
          ? (map['stop_lat'] as num).toDouble()
          : null,
      longitude: map['stop_lon'] != null
          ? (map['stop_lon'] as num).toDouble()
          : null,
      zoneId: map['zone_id'] as String?,
      url: map['stop_url'] as String?,
      locationType: map['location_type'] as int?,
      parentStation: map['parent_station'] as String?,
      timezone: map['stop_timezone'] as String?,
      wheelchairBoarding: map['wheelchair_boarding'] as int?,
      levelId: map['level_id'] as String?,
      platformCode: map['platform_code'] as String?,
    );
  }

  @override
  String toString() {
    return 'Stop(id: $id, code: $code, name: $name, ttsName: $ttsName, description: $description, latitude: $latitude, longitude: $longitude, zoneId: $zoneId, url: $url, locationType: $locationType, parentStation: $parentStation, timezone: $timezone, wheelchairBoarding: $wheelchairBoarding, levelId: $levelId, platformCode: $platformCode)';
  }
}
