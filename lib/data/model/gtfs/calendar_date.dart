import 'package:objectbox/objectbox.dart';

@Entity()
class CalendarDate {
  @Id()
  int id = 0;

  @Index()
  final String serviceId;

  @Index()
  final String? agencyId;

  @Index()
  final String date;

  final int exceptionType;

  CalendarDate({
    this.id = 0,
    required this.serviceId,
    this.agencyId,
    required this.date,
    required this.exceptionType,
  }) : assert(serviceId.isNotEmpty, 'serviceId cannot be empty'),
       assert(
         RegExp(r'^\d{8}$').hasMatch(date),
         'date must be in YYYYMMDD format',
       ),
       assert(
         exceptionType == 1 || exceptionType == 2,
         'exceptionType must be 1 or 2',
       );

  factory CalendarDate.fromMap(Map<String, dynamic> map) {
    return CalendarDate(
      serviceId: map['service_id']?.toString() ?? '',
      agencyId: map['agency_id']?.toString(),
      date: map['date']?.toString() ?? '',
      exceptionType: int.tryParse(map['exception_type']?.toString() ?? '') ?? 1,
    );
  }

  @override
  String toString() {
    return 'CalendarDate(serviceId: $serviceId, date: $date, exceptionType: $exceptionType)';
  }
}
