// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of '../repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(transportAgencyRepository)
final transportAgencyRepositoryProvider = TransportAgencyRepositoryProvider._();

final class TransportAgencyRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<TransportAgencyRepository>,
          TransportAgencyRepository,
          FutureOr<TransportAgencyRepository>
        >
    with
        $FutureModifier<TransportAgencyRepository>,
        $FutureProvider<TransportAgencyRepository> {
  TransportAgencyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transportAgencyRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transportAgencyRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<TransportAgencyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TransportAgencyRepository> create(Ref ref) {
    return transportAgencyRepository(ref);
  }
}

String _$transportAgencyRepositoryHash() =>
    r'046f67b232ce53cbe4f6ecb95427cd839349af94';
