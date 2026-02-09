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

extension StringExtension on String? {
  String formatHeadsign() {
    if (this == null || this!.isEmpty) return 'Unknown Route';

    String text = this!;
    if (text.startsWith('*')) {
      text = text.substring(1);
    }

    return text.split(' ').map((word) {
      if (word.isEmpty) return word;

      final firstLetterIdx = word.indexOf(
        RegExp(r'[a-zA-ZáéíóúàèìòùâêîôûãõçÁÉÍÓÚÀÈÌÒÙÂÊÎÔÛÃÕÇ]'),
      );
      if (firstLetterIdx == -1) return word.toLowerCase();

      return word.substring(0, firstLetterIdx).toLowerCase() +
          word[firstLetterIdx].toUpperCase() +
          word.substring(firstLetterIdx + 1).toLowerCase();
    }).join(' ');
  }
}
