class CalendarDate {
  /// Identifies a set of dates when a service exception occurs (required)
  final String serviceId;

  /// Date when service exception occurs (required, format YYYYMMDD)
  final String date;

  /// Indicates whether service is available on the date (required, 1 or 2)
  final int exceptionType;

  CalendarDate({
    required this.serviceId,
    required this.date,
    required this.exceptionType,
  }) : assert(serviceId.isNotEmpty, 'serviceId cannot be empty'),
       assert(
         RegExp(r'^\d{8}\u0000?$').hasMatch(date),
         'date must be in YYYYMMDD format',
       ),
       assert(
         exceptionType == 1 || exceptionType == 2,
         'exceptionType must be 1 or 2',
       );

  factory CalendarDate.fromMap(Map<String, dynamic> map) {
    return CalendarDate(
      serviceId: map['service_id'] as String,
      date: map['date'] as String,
      exceptionType: map['exception_type'] as int,
    );
  }

  @override
  String toString() {
    return 'CalendarDate(serviceId: $serviceId, date: $date, exceptionType: $exceptionType)';
  }
}
