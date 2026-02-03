// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cacheDatabase)
final cacheDatabaseProvider = CacheDatabaseProvider._();

final class CacheDatabaseProvider
    extends
        $FunctionalProvider<AsyncValue<Database>, Database, FutureOr<Database>>
    with $FutureModifier<Database>, $FutureProvider<Database> {
  CacheDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<Database> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Database> create(Ref ref) {
    return cacheDatabase(ref);
  }
}

String _$cacheDatabaseHash() => r'4c9264245beff21acdbac9de149f1664c9393efa';

@ProviderFor(stopsCache)
final stopsCacheProvider = StopsCacheProvider._();

final class StopsCacheProvider
    extends
        $FunctionalProvider<
          AsyncValue<PersistentCache<List<Stop>>>,
          PersistentCache<List<Stop>>,
          FutureOr<PersistentCache<List<Stop>>>
        >
    with
        $FutureModifier<PersistentCache<List<Stop>>>,
        $FutureProvider<PersistentCache<List<Stop>>> {
  StopsCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stopsCacheProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stopsCacheHash();

  @$internal
  @override
  $FutureProviderElement<PersistentCache<List<Stop>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PersistentCache<List<Stop>>> create(Ref ref) {
    return stopsCache(ref);
  }
}

String _$stopsCacheHash() => r'1d7f1e366df0fbeb3a19b94688e3f6df6648a27a';
