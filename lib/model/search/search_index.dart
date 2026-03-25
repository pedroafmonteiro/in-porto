import 'package:in_porto/model/search/searchable_item.dart';

class _SearchableItemInternal {
  final SearchableItem item;
  final String normalizedPrimary;
  final String? normalizedSecondary;
  final List<String> normalizedKeywords;

  _SearchableItemInternal(this.item)
    : normalizedPrimary = item.primaryLabel.toLowerCase(),
      normalizedSecondary = item.secondaryLabel?.toLowerCase(),
      normalizedKeywords = item.searchKeywords
          .map((k) => k.toLowerCase())
          .toList();
}

class SearchIndex {
  final List<_SearchableItemInternal> _internalItems;

  SearchIndex({required List<SearchableItem> items})
    : _internalItems = items.map((i) => _SearchableItemInternal(i)).toList();

  List<SearchResult> search(String query) {
    if (query.isEmpty) return [];

    final normalizedQuery = query.toLowerCase().trim();
    final results = <SearchResult>[];

    for (final internal in _internalItems) {
      final score = _calculateScore(internal, normalizedQuery);
      if (score > 0) {
        final item = internal.item;
        results.add(
          SearchResult(
            id: item.id,
            title: item.primaryLabel,
            subtitle: item.secondaryLabel,
            type: item.type,
            source: item.source,
            score: score,
          ),
        );
      }
    }

    results.sort((a, b) => b.score.compareTo(a.score));

    return results;
  }

  int _calculateScore(_SearchableItemInternal internal, String query) {
    int score = 0;

    if (internal.normalizedPrimary == query) {
      score += 100;
    }

    if (internal.normalizedPrimary.startsWith(query)) {
      score += 50;
    }

    if (internal.normalizedPrimary.contains(query)) {
      score += 20;
    }

    final secondary = internal.normalizedSecondary;
    if (secondary != null) {
      if (secondary == query) {
        score += 80;
      } else if (secondary.startsWith(query)) {
        score += 40;
      } else if (secondary.contains(query)) {
        score += 15;
      }
    }

    for (final keyword in internal.normalizedKeywords) {
      if (keyword == query) {
        score += 70;
      } else if (keyword.startsWith(query)) {
        score += 30;
      } else if (keyword.contains(query)) {
        score += 10;
      }
    }

    if (score > 0) {
      if (internal.item.type == SearchResultType.route &&
          internal.normalizedPrimary == query) {
        score += 50;
      }
      if (internal.item.type == SearchResultType.stop &&
          internal.normalizedSecondary == query) {
        score += 40;
      }
    }

    return score;
  }
}
