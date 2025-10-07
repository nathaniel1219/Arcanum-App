import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ConnectivityProvider with ChangeNotifier {
  bool _isOnline = false; // by default it should show offline till goes online
  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    await _checkInternet();

    Connectivity().onConnectivityChanged.listen((_) async {
      await _checkInternet();
    });
  }

  Future<void> _checkInternet() async {
    bool previousStatus = _isOnline;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _isOnline = false;
    } else {
      // pings google to check if its online
      try {
        final response = await http.get(Uri.parse('https://www.google.com'));
        _isOnline = response.statusCode == 200;
      } catch (_) {
        _isOnline = false;
      }
    }

    if (_isOnline != previousStatus) notifyListeners();
  }
}
