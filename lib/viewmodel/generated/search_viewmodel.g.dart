// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../search_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'446383cb599327bea368f8da496260b05a5f9bec';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SearchFilters)
final searchFiltersProvider = SearchFiltersProvider._();

final class SearchFiltersProvider
    extends $NotifierProvider<SearchFilters, SearchResultType?> {
  SearchFiltersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchFiltersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchFiltersHash();

  @$internal
  @override
  SearchFilters create() => SearchFilters();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchResultType? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchResultType?>(value),
    );
  }
}

String _$searchFiltersHash() => r'e38a06ecb6676d7809eea8321e656ed8a0db5deb';

abstract class _$SearchFilters extends $Notifier<SearchResultType?> {
  SearchResultType? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SearchResultType?, SearchResultType?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchResultType?, SearchResultType?>,
              SearchResultType?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(searchIndex)
final searchIndexProvider = SearchIndexProvider._();

final class SearchIndexProvider
    extends
        $FunctionalProvider<
          AsyncValue<SearchIndex>,
          SearchIndex,
          FutureOr<SearchIndex>
        >
    with $FutureModifier<SearchIndex>, $FutureProvider<SearchIndex> {
  SearchIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchIndexHash();

  @$internal
  @override
  $FutureProviderElement<SearchIndex> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SearchIndex> create(Ref ref) {
    return searchIndex(ref);
  }
}

String _$searchIndexHash() => r'44d907af40d2ebc670bb5cb07cd05e6acdc58fd1';

@ProviderFor(rawSearchResults)
final rawSearchResultsProvider = RawSearchResultsProvider._();

final class RawSearchResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SearchResult>>,
          List<SearchResult>,
          FutureOr<List<SearchResult>>
        >
    with
        $FutureModifier<List<SearchResult>>,
        $FutureProvider<List<SearchResult>> {
  RawSearchResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rawSearchResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rawSearchResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<SearchResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SearchResult>> create(Ref ref) {
    return rawSearchResults(ref);
  }
}

String _$rawSearchResultsHash() => r'8153a969e32c03fb5d4420114f60b11aaadc9653';

@ProviderFor(searchResults)
final searchResultsProvider = SearchResultsProvider._();

final class SearchResultsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SearchResult>>,
          AsyncValue<List<SearchResult>>,
          AsyncValue<List<SearchResult>>
        >
    with $Provider<AsyncValue<List<SearchResult>>> {
  SearchResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultsHash();

  @$internal
  @override
  $ProviderElement<AsyncValue<List<SearchResult>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<SearchResult>> create(Ref ref) {
    return searchResults(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<SearchResult>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<SearchResult>>>(
        value,
      ),
    );
  }
}

String _$searchResultsHash() => r'776b67249dbd91a9bbc20636286fcb26e369f43f';
