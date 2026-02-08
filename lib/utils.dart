class TimeUtils {
  static String normalizeTime(String time) {
    final parts = time.split(':');
    if (parts.isEmpty) return time;
    int hour = int.tryParse(parts[0]) ?? 0;
    if (hour >= 24) {
      hour -= 24;
    }
    return '${hour.toString().padLeft(2, '0')}:${parts.sublist(1).join(':')}';
  }

  static bool isLateNight(String time) {
    final hour = int.tryParse(time.split(':').first) ?? 0;
    return hour >= 24;
  }
}
