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

  factory StopTime.fromMap(Map<String, dynamic> map) {
    return StopTime(
      tripId: map['trip_id'] as String,
      arrivalTime: map['arrival_time'] as String?,
      departureTime: map['departure_time'] as String?,
      stopId: map['stop_id'] as String?,
      locationGroupId: map['location_group_id'] as String?,
      locationId: map['location_id'] as String?,
      stopSequence: map['stop_sequence'] as int,
      stopHeadsign: map['stop_headsign'] as String?,
      startPickupDropOffWindow: map['start_pickup_drop_off_window'] as String?,
      endPickupDropOffWindow: map['end_pickup_drop_off_window'] as String?,
      pickupType: map['pickup_type'] as int?,
      dropOffType: map['drop_off_type'] as int?,
      continuousPickup: map['continuous_pickup'] as int?,
      continuousDropOff: map['continuous_drop_off'] as int?,
      shapeDistTraveled: map['shape_dist_traveled'] as double?,
      timepoint: map['timepoint'] as int?,
      pickupBookingRuleId: map['pickup_booking_rule_id'] as String?,
      dropOffBookingRuleId: map['drop_off_booking_rule_id'] as String?,
    );
  }

  @override
  String toString() {
    return 'StopTime(tripId: $tripId, arrivalTime: $arrivalTime, departureTime: $departureTime, stopId: $stopId, locationGroupId: $locationGroupId, locationId: $locationId, stopSequence: $stopSequence, stopHeadsign: $stopHeadsign, startPickupDropOffWindow: $startPickupDropOffWindow, endPickupDropOffWindow: $endPickupDropOffWindow, pickupType: $pickupType, dropOffType: $dropOffType, continuousPickup: $continuousPickup, continuousDropOff: $continuousDropOff, shapeDistTraveled: $shapeDistTraveled, timepoint: $timepoint, pickupBookingRuleId: $pickupBookingRuleId, dropOffBookingRuleId: $dropOffBookingRuleId)';
  }
}
