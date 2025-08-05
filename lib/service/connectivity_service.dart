import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:in_porto/enums.dart';

class ConnectivityService {
  ConnectivityService._privateConstructor();

  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  static final ConnectivityService _instance =
      ConnectivityService._privateConstructor();

  factory ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      for (var result in results) {
        _instance.connectionStatusController.add(
          _instance._getStatusFromResult(result),
        );
      }
    });
    return _instance;
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return ConnectivityStatus.connected;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }
}
