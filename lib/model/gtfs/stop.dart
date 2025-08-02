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

  Stop copyWith({
    String? id,
    String? code,
    String? name,
    String? ttsName,
    String? description,
    double? latitude,
    double? longitude,
    String? zoneId,
    String? url,
    int? locationType,
    String? parentStation,
    String? timezone,
    int? wheelchairBoarding,
    String? levelId,
    String? platformCode,
  }) {
    return Stop(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      ttsName: ttsName ?? this.ttsName,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      zoneId: zoneId ?? this.zoneId,
      url: url ?? this.url,
      locationType: locationType ?? this.locationType,
      parentStation: parentStation ?? this.parentStation,
      timezone: timezone ?? this.timezone,
      wheelchairBoarding: wheelchairBoarding ?? this.wheelchairBoarding,
      levelId: levelId ?? this.levelId,
      platformCode: platformCode ?? this.platformCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stop_id': id,
      if (code != null) 'stop_code': code,
      if (name != null) 'stop_name': name,
      if (ttsName != null) 'tts_stop_name': ttsName,
      if (description != null) 'stop_desc': description,
      if (latitude != null) 'stop_lat': latitude,
      if (longitude != null) 'stop_lon': longitude,
      if (zoneId != null) 'zone_id': zoneId,
      if (url != null) 'stop_url': url,
      if (locationType != null) 'location_type': locationType,
      if (parentStation != null) 'parent_station': parentStation,
      if (timezone != null) 'stop_timezone': timezone,
      if (wheelchairBoarding != null) 'wheelchair_boarding': wheelchairBoarding,
      if (levelId != null) 'level_id': levelId,
      if (platformCode != null) 'platform_code': platformCode,
    };
  }

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      id: json['stop_id'] as String,
      code: json['stop_code'] as String?,
      name: json['stop_name'] as String?,
      ttsName: json['tts_stop_name'] as String?,
      description: json['stop_desc'] as String?,
      latitude: (json['stop_lat'] is double)
          ? json['stop_lat'] as double
          : (json['stop_lat'] != null
                ? double.tryParse(json['stop_lat'].toString())
                : null),
      longitude: (json['stop_lon'] is double)
          ? json['stop_lon'] as double
          : (json['stop_lon'] != null
                ? double.tryParse(json['stop_lon'].toString())
                : null),
      zoneId: json['zone_id'] as String?,
      url: json['stop_url'] as String?,
      locationType: json['location_type'] is int
          ? json['location_type'] as int
          : (json['location_type'] != null
                ? int.tryParse(json['location_type'].toString())
                : null),
      parentStation: json['parent_station'] as String?,
      timezone: json['stop_timezone'] as String?,
      wheelchairBoarding: json['wheelchair_boarding'] is int
          ? json['wheelchair_boarding'] as int
          : (json['wheelchair_boarding'] != null
                ? int.tryParse(json['wheelchair_boarding'].toString())
                : null),
      levelId: json['level_id'] as String?,
      platformCode: json['platform_code'] as String?,
    );
  }

  @override
  String toString() {
    return 'Stop(id: $id, code: $code, name: $name, ttsName: $ttsName, description: $description, latitude: $latitude, longitude: $longitude, zoneId: $zoneId, url: $url, locationType: $locationType, parentStation: $parentStation, timezone: $timezone, wheelchairBoarding: $wheelchairBoarding, levelId: $levelId, platformCode: $platformCode)';
  }
}
