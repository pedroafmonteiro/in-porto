import 'package:in_porto/model/repositories/repository_providers.dart';
import 'package:in_porto/model/search/mappers.dart';
import 'package:in_porto/model/search/search_index.dart';
import 'package:in_porto/model/search/searchable_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_viewmodel.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void update(String query) {
    state = query;
  }
}

@riverpod
Future<SearchIndex> searchIndex(Ref ref) async {
  final repository = await ref.watch(transportAgencyRepositoryProvider.future);
  
  final stops = await repository.getStops();
  final routes = await repository.getRoutes();

  final List<SearchableItem> items = [
    ...stops.map((s) => StopSearchableItem(s)),
    ...routes.map((r) => RouteSearchableItem(r)),
  ];

  return SearchIndex(items: items);
}

@riverpod
Future<List<SearchResult>> searchResults(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  final index = await ref.watch(searchIndexProvider.future);

  if (query.length < 2) return [];

  await Future.delayed(const Duration(milliseconds: 300));
  if (ref.read(searchQueryProvider) != query) {
    return [];
  }

  return index.search(query);
}
