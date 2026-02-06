import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_providers.g.dart';

@riverpod
http.Client httpClient(Ref ref) {
  final client = http.Client();
  ref.onDispose(() => client.close());
  return client;
}
