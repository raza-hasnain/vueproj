import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

import '../utils/enum.dart';

class CheckInternetConnection {
  final Connectivity _connectivity = Connectivity();

  // Default will be online. This controller will help to emit new states when the connection changes.
  final _controller = BehaviorSubject.seeded(ConnectionStatus.online);
  StreamSubscription? _connectionSubscription;

  CheckInternetConnection() {
    _checkInternetConnection();
  }

  // The [ConnectionStatusValueNotifier] will subscribe to this 
  // stream and everytime the connection status change it 
  // will update it's value
  Stream<ConnectionStatus> internetStatus() {
    _connectionSubscription ??= _connectivity.onConnectivityChanged
        .listen((_) => _checkInternetConnection());
    return _controller.stream;
  }

  // Code from stackoverflow
  Future<void> _checkInternetConnection() async {
    try {
	  // Sometimes, after we connect to a network, this function will
	  // be called but the device still do not have internet connection. 
	  // This 3 seconds delay will give some time to the device to 
	  // connect to the internet in order to avoid false-positives
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _controller.sink.add(ConnectionStatus.online);
      } else {
        _controller.sink.add(ConnectionStatus.offline);
      }
    } on SocketException catch (_) {
      _controller.sink.add(ConnectionStatus.offline);
    }
  }

  Future<void> close() async {
  	// Cancel subscription and close controller
    await _connectionSubscription?.cancel();
    await _controller.close();
  }
}