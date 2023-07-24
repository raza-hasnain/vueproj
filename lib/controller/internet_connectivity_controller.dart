import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/enum.dart';

import '../main.dart';

class ConnectionStatusValueNotifier extends ValueNotifier<ConnectionStatus> {
  // Will keep a subscription to
  // the class [CheckInternetConnection]
  late StreamSubscription _connectionSubscription;  
  
  ConnectionStatusValueNotifier() : super(ConnectionStatus.online) {
    // Everytime there a new connection status is emitted
    // we will update the [value]. This will make the widget
    // to rebuild
    _connectionSubscription = internetChecker  
        .internetStatus()  
        .listen((newStatus) => value = newStatus);  
  }  
  
  @override  
  void dispose() {  
	 _connectionSubscription.cancel();  
	 super.dispose();  
  }  
}