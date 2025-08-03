import 'package:flutter/foundation.dart';
import 'package:in_porto/service/connectivity_service.dart';
import 'package:in_porto/enums.dart';

class ConnectivityViewmodel extends ChangeNotifier {
  final ConnectivityService _service = ConnectivityService();
  ConnectivityStatus _status = ConnectivityStatus.offline;

  ConnectivityStatus get status => _status;

  ConnectivityViewmodel() {
    _service.connectionStatusController.stream.listen((status) {
      _status = status;
      notifyListeners();
    });
  }
}
