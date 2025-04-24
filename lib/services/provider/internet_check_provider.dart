import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider extends ChangeNotifier {
  late Stream<bool> connectivityStream;

  ConnectivityProvider() {
    connectivityStream = Connectivity()
        .onConnectivityChanged
        .map((event) => ConnectivityUtility.checkConnectivity(event));
  }
}

class ConnectivityUtility {
  static bool checkConnectivity(List<ConnectivityResult> results) {
    for (var result in results) {
      switch (result) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
          return true;
        case ConnectivityResult.bluetooth:
        case ConnectivityResult.none:
        default:
          continue;
      }
    }
    return false;
  }
}
