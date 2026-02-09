import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/schedule.dart';
import 'package:in_porto/model/entities/trip.dart';
import 'package:in_porto/utils.dart';
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

  Future<String> fetchStopServiceId(Stop stop, DateTime? date) async {
    final uri = Uri.parse('$_baseUrl/stops/${stop.id}/services').replace(
      queryParameters: {
        'date':
            date?.toIso8601String().split('T').first ??
            DateTime.now().toIso8601String().split('T').first,
      },
    );
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['active_service_id'] as String;
    } else {
      throw Exception(
        'Failed to load current service for stop ${stop.id}: ${response.statusCode}',
      );
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

  Future<List<Schedule>> fetchStopRouteSchedules(
    Stop stop,
    TransportRoute route,
    String serviceId,
  ) async {
    final uri = Uri.parse('$_baseUrl/stops/${stop.id}/schedule').replace(
      queryParameters: {
        'route_id': route.id,
        'service_id': serviceId,
        'direction_id': route.directionId?.toString(),
      },
    );

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Schedule> schedules = [];

      final dynamic scheduleData = data['schedule'];
      final List<dynamic> hourlyGroups = [];
      if (scheduleData is Map) {
        hourlyGroups.addAll(scheduleData.values);
      } else if (scheduleData is List) {
        hourlyGroups.addAll(scheduleData);
      }

      for (final arrivalsByHour in hourlyGroups) {
        if (arrivalsByHour is List) {
          for (final arrivalData in arrivalsByHour) {
            if (arrivalData is Map<String, dynamic> &&
                arrivalData['departure_time'] != null) {
              schedules.add(
                Schedule.fromJson({
                  'stop_id': stop.id,
                  'route_id': route.id,
                  'direction_id': route.directionId?.toString(),
                  'service_id': serviceId,
                  'departure_time': arrivalData['departure_time'],
                  'headsign': (arrivalData['headsign'] as String?).formatHeadsign(),
                }),
              );
            }
          }
        }
      }

      return schedules;
    } else {
      throw Exception(
        'Failed to load schedules for stop ${stop.id}: ${response.statusCode}',
      );
    }
  }

  Future<List<Trip>> fetchStopRealtimeTrips(Stop stop) async {
    final uri = Uri.parse('$_baseUrl/stops/${stop.id}/realtime');
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> results = data['arrivals'];

      return results.map((json) {
        if (json is Map<String, dynamic> && json['trip_headsign'] != null) {
          json['trip_headsign'] =
              (json['trip_headsign'] as String).formatHeadsign();
        }
        return Trip.fromJson(json);
      }).toList();
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
