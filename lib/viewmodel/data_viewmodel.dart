import 'package:flutter/foundation.dart';
import '../data/repository/gtfs_repository.dart';

class DataViewModel extends ChangeNotifier {
  final GtfsRepository _repository = GtfsRepository();

  DataViewModel() {
    _checkDataStatus();
  }

  final Map<String, AgencyLoadStatus> _agencyStatus = {};
  Map<String, AgencyLoadStatus> get agencyStatus =>
      Map.unmodifiable(_agencyStatus);

  final Map<String, double> _agencyProgress = {};
  Map<String, double> get agencyProgress => Map.unmodifiable(_agencyProgress);

  String? _currentAgency;
  String? get currentAgency => _currentAgency;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isDataLoaded =>
      _agencyStatus.isNotEmpty &&
      _agencyStatus.values.every((status) => status == AgencyLoadStatus.done);

  Future<void> _checkDataStatus() async {
    final agencies = _repository.getAgencies();
    for (final agency in agencies) {
      _agencyStatus[agency.name] = AgencyLoadStatus.idle;
      _agencyProgress[agency.name] = 0.0;
    }

    final isLoaded = await _repository.isDataLoaded();
    if (isLoaded) {
      for (final agency in agencies) {
        _agencyStatus[agency.name] = AgencyLoadStatus.done;
        _agencyProgress[agency.name] = 1.0;
      }
    }
    notifyListeners();
  }

  Future<void> loadGtfsData() async {
    _isLoading = true;
    notifyListeners();

    final agencies = _repository.getAgencies();
    for (final agency in agencies) {
      _currentAgency = agency.name;
      _agencyStatus[agency.name] = AgencyLoadStatus.loading;
      _agencyProgress[agency.name] = 0.0;
      notifyListeners();
      try {
        await _repository.syncAgencyData(
          agency,
          onProgress: (progress) {
            _agencyProgress[agency.name] = progress;
            notifyListeners();
          },
        );
        _agencyStatus[agency.name] = AgencyLoadStatus.done;
        _agencyProgress[agency.name] = 1.0;
      } catch (e) {
        _agencyStatus[agency.name] = AgencyLoadStatus.failed;
        _agencyProgress[agency.name] = 0.0;
      }
      notifyListeners();
    }
    _currentAgency = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteAllGtfsData() async {
    await _repository.clearAllData();
    final agencies = _repository.getAgencies();
    for (final agency in agencies) {
      _agencyStatus[agency.name] = AgencyLoadStatus.idle;
      _agencyProgress[agency.name] = 0.0;
    }
    notifyListeners();
  }
}

enum AgencyLoadStatus {
  idle,
  loading,
  done,
  failed,
}
