import 'package:in_porto/model/repositories/stcp_repository.dart';
import 'package:in_porto/model/repositories/transport_agency_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/repository_providers.g.dart';

@riverpod
Future<TransportAgencyRepository> transportAgencyRepository(Ref ref) async {
  return ref.watch(stcpRepositoryProvider.future);
}
