import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetService {
  InternetService({InternetConnection? internetConnection})
      : _internetConnection = internetConnection ?? InternetConnection();

  final InternetConnection _internetConnection;

  Stream<bool> get onStatusChange {
    return _internetConnection.onStatusChange
        .map((status) => status == InternetStatus.connected)
        .distinct();
  }

  Future<bool> hasInternet() {
    return _internetConnection.hasInternetAccess;
  }
}
