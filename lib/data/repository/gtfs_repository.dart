import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

import '../source/remote/gtfs_remote_source.dart';
import '../source/local/gtfs_local_source.dart';
import '../source/remote/agency_remote_source.dart';
import '../parser/gtfs_parser.dart';
import '../registry/agency_registry.dart';
import '../model/app_agency.dart';
import '../model/gtfs_resource_info.dart';

class GtfsRepository {
  final GtfsRemoteDataSource _gtfsRemoteSource = GtfsRemoteDataSource();
  final AgencyRemoteSource _agencyRemoteSource = AgencyRemoteSource();
  final GtfsLocalDataSource _localSource = GtfsLocalDataSource();

  static const _keyLastUrlPrefix = 'gtfs_last_url_';
  static const _keyResourceIdPrefix = 'gtfs_resource_id_';

  List<AppAgency> getAgencies() {
    return AgencyRegistry.agencies;
  }

  Future<void> syncAgencyData(
    AppAgency agency, {
    Function(double)? onProgress,
  }) async {
    if (onProgress != null) onProgress(0.05);

    final resources = await fetchRemoteResources(agency);

    if (resources.isEmpty) {
      throw Exception('No resources found for ${agency.id}');
    }

    final newestResource = resources.first;
    final isNew = await isNewResourceAvailable(agency, newestResource);
    final hasLocalData = await _localSource.hasDataForAgency(agency.id);

    if (!isNew && hasLocalData) {
      if (onProgress != null) onProgress(1.0);
      return;
    }

    final downloadResult = await downloadBestAvailableResource(
      agency,
      resources,
      onProgress: (val) {
        if (onProgress != null) {
          final p = 0.05 + (val * 0.35);
          onProgress(p);
        }
      },
    );
    final file = downloadResult.file;
    final usedResource = downloadResult.resource;

    try {
      await processData(
        agency,
        file,
        onProgress: (val) {
          if (onProgress != null) {
            // Map 0.0-1.0 to 0.40-0.95
            final p = 0.40 + (val * 0.55);
            onProgress(p);
          }
        },
      );

      await updateMetadata(agency, usedResource);

      if (onProgress != null) onProgress(1.0);
    } finally {
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  Future<List<GtfsResourceInfo>> fetchRemoteResources(AppAgency agency) async {
    try {
      return await _agencyRemoteSource.fetchGtfsResourceInfo(agency.type);
    } catch (e) {
      final prefs = await SharedPreferences.getInstance();
      final lastUrl = prefs.getString('$_keyLastUrlPrefix${agency.id}');
      if (lastUrl != null) {
        return [GtfsResourceInfo(url: lastUrl, resourceId: 'fallback')];
      }
      rethrow;
    }
  }

  Future<bool> isNewResourceAvailable(
    AppAgency agency,
    GtfsResourceInfo resource,
  ) async {
    if (resource.resourceId == 'static' || resource.resourceId == 'fallback') {
      return true;
    }
    final prefs = await SharedPreferences.getInstance();
    final storedResourceId = prefs.getString(
      '$_keyResourceIdPrefix${agency.id}',
    );
    return storedResourceId != resource.resourceId;
  }

  Future<({File file, GtfsResourceInfo resource})>
  downloadBestAvailableResource(
    AppAgency agency,
    List<GtfsResourceInfo> resources, {
    Function(double)? onProgress,
  }) async {
    final tempDir = Directory.systemTemp;

    for (final resource in resources) {
      final fileName = '${resource.resourceId}_${agency.id}.zip';
      final tempPath = p.join(tempDir.path, fileName);
      try {
        await _gtfsRemoteSource.downloadGtfsFile(
          resource.url,
          tempPath,
          onProgress: onProgress,
        );
        final file = File(tempPath);
        if (await file.length() > 0) {
          return (file: file, resource: resource);
        }
      } catch (e) {
        // Log and try next
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final lastUrl = prefs.getString('$_keyLastUrlPrefix${agency.id}');

    if (lastUrl != null && !resources.any((r) => r.url == lastUrl)) {
      final fileName = 'fallback_${agency.id}.zip';
      final tempPath = p.join(tempDir.path, fileName);
      try {
        await _gtfsRemoteSource.downloadGtfsFile(
          lastUrl,
          tempPath,
          onProgress: onProgress,
        );
        final file = File(tempPath);
        if (await file.length() > 0) {
          return (
            file: file,
            resource: GtfsResourceInfo(url: lastUrl, resourceId: 'fallback'),
          );
        }
      } catch (e) {
        // Log and fail
      }
    }

    throw Exception('All download attempts failed for ${agency.id}');
  }

  Future<void> processData(
    AppAgency agency,
    File file, {
    Function(double)? onProgress,
  }) async {
    final zipBytes = await file.readAsBytes();
    final parser = GtfsParser(zipBytes);
    final agencyIdOverride = agency.id;

    final steps = [
      (
        file: 'agency.txt',
        table: _localSource.agencyTable,
        weight: 0.01,
        requiresOverride: true,
      ),
      (
        file: 'calendar.txt',
        table: _localSource.calendarTable,
        weight: 0.02,
        requiresOverride: false,
      ),
      (
        file: 'calendar_dates.txt',
        table: _localSource.calendarDatesTable,
        weight: 0.02,
        requiresOverride: false,
      ),
      (
        file: 'routes.txt',
        table: _localSource.routeTable,
        weight: 0.05,
        requiresOverride: true,
      ),
      (
        file: 'trips.txt',
        table: _localSource.tripTable,
        weight: 0.10,
        requiresOverride: false,
      ),
      (
        file: 'stops.txt',
        table: _localSource.stopTable,
        weight: 0.10,
        requiresOverride: false,
      ),
      (
        file: 'shapes.txt',
        table: _localSource.shapeTable,
        weight: 0.10,
        requiresOverride: false,
      ),
      (
        file: 'stop_times.txt',
        table: _localSource.stopTimeTable,
        weight: 0.60,
        requiresOverride: false,
      ),
    ];

    double currentBaseProgress = 0.0;

    for (final step in steps) {
      if (parser.hasFile(step.file)) {
        final totalRows = parser.getRowCount(step.file);
        final data = parser.parseFile(
          step.file,
          agencyIdOverride: step.requiresOverride ? agencyIdOverride : null,
        );

        await _localSource.insertBatch(
          step.table,
          data,
          totalRows: totalRows,
          onProgress: (stepProgress) {
            if (onProgress != null) {
              final totalProgress =
                  currentBaseProgress + (stepProgress * step.weight);
              onProgress(totalProgress);
            }
          },
        );
      }
      currentBaseProgress += step.weight;
      if (onProgress != null) onProgress(currentBaseProgress);
    }
  }

  Future<void> updateMetadata(
    AppAgency agency,
    GtfsResourceInfo resource,
  ) async {
    if (resource.resourceId != 'fallback' && resource.resourceId != 'static') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        '$_keyResourceIdPrefix${agency.id}',
        resource.resourceId,
      );
      await prefs.setString('$_keyLastUrlPrefix${agency.id}', resource.url);
    }
  }

  Future<bool> isDataLoaded() async {
    final counts = await _localSource.getDataCounts();
    return counts.values.every((c) => c > 0);
  }

  Future<Map<String, int>> getDataCounts() async {
    return await _localSource.getDataCounts();
  }

  Future<void> clearAllData() async {
    await _localSource.deleteAll();
  }
}
