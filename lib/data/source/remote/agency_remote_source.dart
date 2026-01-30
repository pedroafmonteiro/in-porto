import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/agency_type.dart';
import '../../model/gtfs_resource_info.dart';

class AgencyRemoteSource {
  static const _ckanBaseUrl = 'https://opendata.porto.digital/api/3/action/package_show';

  Future<List<GtfsResourceInfo>> fetchGtfsResourceInfo(AgencyType type) async {
    if (type is StaticAgencyType) {
      return [GtfsResourceInfo(url: type.url, resourceId: 'static')];
    } else if (type is CkanAgencyType) {
      return _fetchCkanResources(type.datasetId);
    } else {
      throw Exception('Unknown AgencyType: $type');
    }
  }

  Future<List<GtfsResourceInfo>> _fetchCkanResources(String datasetId) async {
    final uri = Uri.parse('$_ckanBaseUrl?id=$datasetId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['success'] == true) {
        final result = json['result'];
        if (result != null && result['resources'] != null) {
          final resources = (result['resources'] as List).cast<Map<String, dynamic>>();
          
          final zipResources = resources.where((r) {
            final format = (r['format'] as String?)?.toUpperCase() ?? '';
            return format == 'ZIP' || format == 'GTFS';
          }).toList();

          if (zipResources.isEmpty) {
             throw Exception('No ZIP/GTFS resources found for dataset $datasetId');
          }

          zipResources.sort((a, b) {
            final dateA = DateTime.tryParse(a['last_modified'] ?? '') ?? DateTime(0);
            final dateB = DateTime.tryParse(b['last_modified'] ?? '') ?? DateTime(0);
            return dateB.compareTo(dateA);
          });

          return zipResources
              .where((r) => r['url'] != null && r['id'] != null)
              .map((r) => GtfsResourceInfo(url: r['url'] as String, resourceId: r['id'] as String))
              .toList();
        }
      }
    }
    throw Exception('Failed to fetch CKAN resource for dataset $datasetId');
  }
}