// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stcp_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(stcpRepository)
final stcpRepositoryProvider = StcpRepositoryProvider._();

final class StcpRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<STCPRepository>,
          STCPRepository,
          FutureOr<STCPRepository>
        >
    with $FutureModifier<STCPRepository>, $FutureProvider<STCPRepository> {
  StcpRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stcpRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stcpRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<STCPRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<STCPRepository> create(Ref ref) {
    return stcpRepository(ref);
  }
}

String _$stcpRepositoryHash() => r'021d1b472b4ce2b3ae012c183f9917f8f9d26516';
