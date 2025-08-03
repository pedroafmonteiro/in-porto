import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../service/gtfs_service.dart';

class DataViewModel extends ChangeNotifier {
  final Database _db;
  final GTFSService _gtfsService = GTFSService();

  DataViewModel({required Database db}) : _db = db {
    _gtfsService.setDatabase(_db);
    for (final agency in GTFSService.defaultAgencyUrls.keys) {
      _agencyStatus[agency] = AgencyLoadStatus.idle;
    }
  }

  final Map<String, AgencyLoadStatus> _agencyStatus = {};
  Map<String, AgencyLoadStatus> get agencyStatus =>
      Map.unmodifiable(_agencyStatus);

  String? _statusMessage;
  String? get statusMessage => _statusMessage;

  String? _currentAgency;
  String? get currentAgency => _currentAgency;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadGtfsData() async {
    _isLoading = true;
    _statusMessage = null;
    notifyListeners();

    for (final entry in GTFSService.defaultAgencyUrls.entries) {
      final agency = entry.key;
      _currentAgency = agency;
      _agencyStatus[agency] = AgencyLoadStatus.loading;
      _statusMessage = 'Loading GTFS data for agency: $agency';
      notifyListeners();
      try {
        final zipBytes = await _gtfsService.fetchGtfsZip(agency);
        await _gtfsService.parseGtfsZip(zipBytes, gtfsUrl: entry.value);
        _statusMessage =
            "Loaded and cached raw GTFS data for agency: '$agency'";
        _agencyStatus[agency] = AgencyLoadStatus.done;
      } catch (e) {
        _statusMessage = 'Error loading data for $agency: $e';
        _agencyStatus[agency] = AgencyLoadStatus.failed;
      }
      notifyListeners();
    }
    _currentAgency = null;
    _isLoading = false;
    notifyListeners();
  }
}

enum AgencyLoadStatus {
  idle,
  loading,
  done,
  failed,
}
