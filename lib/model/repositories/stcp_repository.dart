import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/trip.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:in_porto/model/infrastructure/cache.dart';
import 'package:in_porto/model/infrastructure/network_providers.dart';
import 'package:in_porto/model/infrastructure/storage_providers.dart';
import 'package:in_porto/model/entities/stop.dart';

part 'stcp_repository.g.dart';

class STCPRepository {
  final http.Client _client;
  final String _baseUrl = 'https://stcp.pt/api';
  final PersistentCache<List<Stop>> _stopsCache;

  STCPRepository(this._client, this._stopsCache);

  Future<List<Stop>> getStops({bool forceRefresh = false}) async {
    return _stopsCache.getOrFetch(
      fetcher: _fetchAllStopsFromRemote,
      forceRefresh: forceRefresh,
    );
  }

  Future<List<Stop>> _fetchAllStopsFromRemote() async {
    final uri = Uri.parse('$_baseUrl/stops').replace(
      queryParameters: {'limit': '3000'},
    );

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];

      return results.map((json) => Stop.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get all stops: ${response.statusCode}');
    }
  }

  Future<List<TransportRoute>> fetchStopRoutes(Stop stop) async {
    final uri = Uri.parse('$_baseUrl/stops/${stop.id}/routes');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['dropdown_routes'];

      return results.map((json) => TransportRoute.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stop ${stop.id}: ${response.statusCode}');
    }
  }

  Future<List<Trip>> fetchStopRealtimeTrips(Stop stop) async {
    final uri = Uri.parse('$_baseUrl/stops/${stop.id}/realtime');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['arrivals'];

      return results.map((json) => Trip.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load realtime routes for stop ${stop.id}: ${response.statusCode}',
      );
    }
  }
}

@riverpod
Future<STCPRepository> stcpRepository(Ref ref) async {
  final client = ref.watch(httpClientProvider);
  final cache = await ref.watch(stopsCacheProvider.future);
  return STCPRepository(client, cache);
}
