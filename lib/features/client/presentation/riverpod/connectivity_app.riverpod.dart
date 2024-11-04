import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum ConnectionStatus { connected, disconnected }

final connectionStatusProvider = StreamProvider<ConnectionStatus>((ref) async* {
  await for (List<ConnectivityResult> result
      in Connectivity().onConnectivityChanged) {
    bool hasInternet = await InternetConnectionChecker().hasConnection;
    result.map(
      (e) async* {
        if (e == ConnectivityResult.none || !hasInternet) {
          yield ConnectionStatus.disconnected;
        } else {
          yield ConnectionStatus.connected;
        }
      },
    );
  }
});
