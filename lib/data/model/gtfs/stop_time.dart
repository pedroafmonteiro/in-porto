import 'package:objectbox/objectbox.dart';
import 'trip.dart';
import 'stop.dart';

@Entity()
class StopTime {
  @Id()
  int id = 0;

  @Index()
  final String tripGtfsId;

  final String? arrivalTime;

  final String? departureTime;

  final String? stopGtfsId;

  final String? locationGroupId;

  final String? locationId;

  final int stopSequence;

  final String? stopHeadsign;

  final String? startPickupDropOffWindow;

  final String? endPickupDropOffWindow;

  final int? pickupType;

  final int? dropOffType;

  final int? continuousPickup;

  final int? continuousDropOff;

  final double? shapeDistTraveled;

  final int? timepoint;

  final String? pickupBookingRuleId;

  final String? dropOffBookingRuleId;

  final trip = ToOne<Trip>();
  final stop = ToOne<Stop>();

  StopTime({
    this.id = 0,
    required this.tripGtfsId,
    this.arrivalTime,
    this.departureTime,
    this.stopGtfsId,
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
  }) : assert(tripGtfsId.isNotEmpty, 'tripGtfsId cannot be empty'),
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
      tripGtfsId: map['trip_id']?.toString() ?? '',
      arrivalTime: map['arrival_time']?.toString(),
      departureTime: map['departure_time']?.toString(),
      stopGtfsId: map['stop_id']?.toString(),
      locationGroupId: map['location_group_id']?.toString(),
      locationId: map['location_id']?.toString(),
      stopSequence: int.tryParse(map['stop_sequence']?.toString() ?? '') ?? 0,
      stopHeadsign: map['stop_headsign']?.toString(),
      startPickupDropOffWindow: map['start_pickup_drop_off_window']?.toString(),
      endPickupDropOffWindow: map['end_pickup_drop_off_window']?.toString(),
      pickupType: int.tryParse(map['pickup_type']?.toString() ?? ''),
      dropOffType: int.tryParse(map['drop_off_type']?.toString() ?? ''),
      continuousPickup: int.tryParse(
        map['continuous_pickup']?.toString() ?? '',
      ),
      continuousDropOff: int.tryParse(
        map['continuous_drop_off']?.toString() ?? '',
      ),
      shapeDistTraveled: double.tryParse(
        map['shape_dist_traveled']?.toString() ?? '',
      ),
      timepoint: int.tryParse(map['timepoint']?.toString() ?? ''),
      pickupBookingRuleId: map['pickup_booking_rule_id']?.toString(),
      dropOffBookingRuleId: map['drop_off_booking_rule_id']?.toString(),
    );
  }

  @override
  String toString() {
    return 'StopTime(tripGtfsId: $tripGtfsId, arrivalTime: $arrivalTime, departureTime: $departureTime, stopGtfsId: $stopGtfsId, locationGroupId: $locationGroupId, locationId: $locationId, stopSequence: $stopSequence, stopHeadsign: $stopHeadsign, startPickupDropOffWindow: $startPickupDropOffWindow, endPickupDropOffWindow: $endPickupDropOffWindow, pickupType: $pickupType, dropOffType: $dropOffType, continuousPickup: $continuousPickup, continuousDropOff: $continuousDropOff, shapeDistTraveled: $shapeDistTraveled, timepoint: $timepoint, pickupBookingRuleId: $pickupBookingRuleId, dropOffBookingRuleId: $dropOffBookingRuleId)';
  }
}
