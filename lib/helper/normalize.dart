String? normalizeColor(String? color) {
  if (color == null || color.isEmpty) return null;

  String normalized = color.startsWith('#') ? color.substring(1) : color;

  if (normalized.length < 6) {
    normalized = normalized.padLeft(6, '0');
  }

  if (normalized.length > 6) {
    normalized = normalized.substring(0, 6);
  }

  if (RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(normalized)) {
    return normalized;
  }

  return null;
}
