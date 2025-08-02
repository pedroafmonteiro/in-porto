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

  CalendarDate copyWith({
    String? serviceId,
    String? date,
    int? exceptionType,
  }) {
    return CalendarDate(
      serviceId: serviceId ?? this.serviceId,
      date: date ?? this.date,
      exceptionType: exceptionType ?? this.exceptionType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'date': date,
      'exception_type': exceptionType,
    };
  }

  factory CalendarDate.fromJson(Map<String, dynamic> json) {
    return CalendarDate(
      serviceId: json['service_id'] as String,
      date: json['date'] as String,
      exceptionType: json['exception_type'] is int
          ? json['exception_type'] as int
          : int.parse(json['exception_type'].toString()),
    );
  }

  @override
  String toString() {
    return 'CalendarDate(serviceId: $serviceId, date: $date, exceptionType: $exceptionType)';
  }
}
