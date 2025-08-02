class StopTime {
  /// Trip ID (required)
  final String tripId;

  /// Arrival time (conditionally required, format HH:MM:SS)
  final String? arrivalTime;

  /// Departure time (conditionally required, format HH:MM:SS)
  final String? departureTime;

  /// Serviced stop ID (conditionally required)
  final String? stopId;

  /// Serviced location group ID (conditionally forbidden)
  final String? locationGroupId;

  /// Serviced GeoJSON location ID (conditionally forbidden)
  final String? locationId;

  /// Order of stops (required, non-negative integer)
  final int stopSequence;

  /// Stop headsign (optional)
  final String? stopHeadsign;

  /// Start pickup drop off window (conditionally required, format HH:MM:SS)
  final String? startPickupDropOffWindow;

  /// End pickup drop off window (conditionally required, format HH:MM:SS)
  final String? endPickupDropOffWindow;

  /// Pickup type (conditionally forbidden, 0-3)
  final int? pickupType;

  /// Drop off type (conditionally forbidden, 0-3)
  final int? dropOffType;

  /// Continuous pickup (conditionally forbidden, 0-3)
  final int? continuousPickup;

  /// Continuous drop off (conditionally forbidden, 0-3)
  final int? continuousDropOff;

  /// Distance traveled along shape (optional, non-negative float)
  final double? shapeDistTraveled;

  /// Timepoint (optional, 0 or 1)
  final int? timepoint;

  /// Pickup booking rule ID (optional)
  final String? pickupBookingRuleId;

  /// Drop off booking rule ID (optional)
  final String? dropOffBookingRuleId;

  StopTime({
    required this.tripId,
    this.arrivalTime,
    this.departureTime,
    this.stopId,
    this.locationGroupId,
    this.locationId,
    required this.stopSequence,
    this.stopHeadsign,
    this.startPickupDropOffWindow,
    this.endPickupDropOffWindow,
    this.pickupType,
    this.dropOffType,
    this.continuousPickup,
    this.continuousDropOff,
    this.shapeDistTraveled,
    this.timepoint,
    this.pickupBookingRuleId,
    this.dropOffBookingRuleId,
  }) : assert(tripId.isNotEmpty, 'tripId cannot be empty'),
       assert(stopSequence >= 0, 'stopSequence must be non-negative'),
       assert(
         pickupType == null || (pickupType >= 0 && pickupType <= 3),
         'pickupType must be 0, 1, 2, or 3',
       ),
       assert(
         dropOffType == null || (dropOffType >= 0 && dropOffType <= 3),
         'dropOffType must be 0, 1, 2, or 3',
       ),
       assert(
         continuousPickup == null ||
             (continuousPickup >= 0 && continuousPickup <= 3),
         'continuousPickup must be 0, 1, 2, or 3',
       ),
       assert(
         continuousDropOff == null ||
             (continuousDropOff >= 0 && continuousDropOff <= 3),
         'continuousDropOff must be 0, 1, 2, or 3',
       ),
       assert(
         timepoint == null || timepoint == 0 || timepoint == 1,
         'timepoint must be 0 or 1',
       ),
       assert(
         shapeDistTraveled == null || shapeDistTraveled >= 0,
         'shapeDistTraveled must be non-negative',
       );

  StopTime copyWith({
    String? tripId,
    String? arrivalTime,
    String? departureTime,
    String? stopId,
    String? locationGroupId,
    String? locationId,
    int? stopSequence,
    String? stopHeadsign,
    String? startPickupDropOffWindow,
    String? endPickupDropOffWindow,
    int? pickupType,
    int? dropOffType,
    int? continuousPickup,
    int? continuousDropOff,
    double? shapeDistTraveled,
    int? timepoint,
    String? pickupBookingRuleId,
    String? dropOffBookingRuleId,
  }) {
    return StopTime(
      tripId: tripId ?? this.tripId,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      departureTime: departureTime ?? this.departureTime,
      stopId: stopId ?? this.stopId,
      locationGroupId: locationGroupId ?? this.locationGroupId,
      locationId: locationId ?? this.locationId,
      stopSequence: stopSequence ?? this.stopSequence,
      stopHeadsign: stopHeadsign ?? this.stopHeadsign,
      startPickupDropOffWindow:
          startPickupDropOffWindow ?? this.startPickupDropOffWindow,
      endPickupDropOffWindow:
          endPickupDropOffWindow ?? this.endPickupDropOffWindow,
      pickupType: pickupType ?? this.pickupType,
      dropOffType: dropOffType ?? this.dropOffType,
      continuousPickup: continuousPickup ?? this.continuousPickup,
      continuousDropOff: continuousDropOff ?? this.continuousDropOff,
      shapeDistTraveled: shapeDistTraveled ?? this.shapeDistTraveled,
      timepoint: timepoint ?? this.timepoint,
      pickupBookingRuleId: pickupBookingRuleId ?? this.pickupBookingRuleId,
      dropOffBookingRuleId: dropOffBookingRuleId ?? this.dropOffBookingRuleId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_id': tripId,
      if (arrivalTime != null) 'arrival_time': arrivalTime,
      if (departureTime != null) 'departure_time': departureTime,
      if (stopId != null) 'stop_id': stopId,
      if (locationGroupId != null) 'location_group_id': locationGroupId,
      if (locationId != null) 'location_id': locationId,
      'stop_sequence': stopSequence,
      if (stopHeadsign != null) 'stop_headsign': stopHeadsign,
      if (startPickupDropOffWindow != null)
        'start_pickup_drop_off_window': startPickupDropOffWindow,
      if (endPickupDropOffWindow != null)
        'end_pickup_drop_off_window': endPickupDropOffWindow,
      if (pickupType != null) 'pickup_type': pickupType,
      if (dropOffType != null) 'drop_off_type': dropOffType,
      if (continuousPickup != null) 'continuous_pickup': continuousPickup,
      if (continuousDropOff != null) 'continuous_drop_off': continuousDropOff,
      if (shapeDistTraveled != null) 'shape_dist_traveled': shapeDistTraveled,
      if (timepoint != null) 'timepoint': timepoint,
      if (pickupBookingRuleId != null)
        'pickup_booking_rule_id': pickupBookingRuleId,
      if (dropOffBookingRuleId != null)
        'drop_off_booking_rule_id': dropOffBookingRuleId,
    };
  }

  factory StopTime.fromJson(Map<String, dynamic> json) {
    return StopTime(
      tripId: json['trip_id'] as String,
      arrivalTime: json['arrival_time'] as String?,
      departureTime: json['departure_time'] as String?,
      stopId: json['stop_id'] as String?,
      locationGroupId: json['location_group_id'] as String?,
      locationId: json['location_id'] as String?,
      stopSequence: json['stop_sequence'] is int
          ? json['stop_sequence'] as int
          : int.parse(json['stop_sequence'].toString()),
      stopHeadsign: json['stop_headsign'] as String?,
      startPickupDropOffWindow: json['start_pickup_drop_off_window'] as String?,
      endPickupDropOffWindow: json['end_pickup_drop_off_window'] as String?,
      pickupType: json['pickup_type'] is int
          ? json['pickup_type'] as int
          : (json['pickup_type'] != null
                ? int.tryParse(json['pickup_type'].toString())
                : null),
      dropOffType: json['drop_off_type'] is int
          ? json['drop_off_type'] as int
          : (json['drop_off_type'] != null
                ? int.tryParse(json['drop_off_type'].toString())
                : null),
      continuousPickup: json['continuous_pickup'] is int
          ? json['continuous_pickup'] as int
          : (json['continuous_pickup'] != null
                ? int.tryParse(json['continuous_pickup'].toString())
                : null),
      continuousDropOff: json['continuous_drop_off'] is int
          ? json['continuous_drop_off'] as int
          : (json['continuous_drop_off'] != null
                ? int.tryParse(json['continuous_drop_off'].toString())
                : null),
      shapeDistTraveled: json['shape_dist_traveled'] is double
          ? json['shape_dist_traveled'] as double
          : (json['shape_dist_traveled'] != null
                ? double.tryParse(json['shape_dist_traveled'].toString())
                : null),
      timepoint: json['timepoint'] is int
          ? json['timepoint'] as int
          : (json['timepoint'] != null
                ? int.tryParse(json['timepoint'].toString())
                : null),
      pickupBookingRuleId: json['pickup_booking_rule_id'] as String?,
      dropOffBookingRuleId: json['drop_off_booking_rule_id'] as String?,
    );
  }

  @override
  String toString() {
    return 'StopTime(tripId: $tripId, arrivalTime: $arrivalTime, departureTime: $departureTime, stopId: $stopId, locationGroupId: $locationGroupId, locationId: $locationId, stopSequence: $stopSequence, stopHeadsign: $stopHeadsign, startPickupDropOffWindow: $startPickupDropOffWindow, endPickupDropOffWindow: $endPickupDropOffWindow, pickupType: $pickupType, dropOffType: $dropOffType, continuousPickup: $continuousPickup, continuousDropOff: $continuousDropOff, shapeDistTraveled: $shapeDistTraveled, timepoint: $timepoint, pickupBookingRuleId: $pickupBookingRuleId, dropOffBookingRuleId: $dropOffBookingRuleId)';
  }
}
