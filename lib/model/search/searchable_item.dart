enum SearchResultType {
  stop,
  route,
}

abstract class SearchableItem {
  String get id;
  String get primaryLabel;
  String? get secondaryLabel;
  List<String> get searchKeywords;
  SearchResultType get type;
  Object get source;
}

class SearchResult {
  final String id;
  final String title;
  final String subtitle;
  final SearchResultType type;
  final Object source;
  final int score;

  SearchResult({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.source,
    this.score = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchResult &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type;

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}
