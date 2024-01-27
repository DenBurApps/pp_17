import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Cодержит метод [checkConnection], который проверяет наличие интернет-соединения
class NetworkService {
  Future<bool> checkConnection() async =>
      await Connectivity().checkConnectivity() != ConnectivityResult.none;
}
