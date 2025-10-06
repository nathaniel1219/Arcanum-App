import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ConnectivityProvider with ChangeNotifier {
  bool _isOnline = false; // assume offline until checked
  bool get isOnline => _isOnline;

  ConnectivityProvider() {
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    await _checkInternet();

    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((_) async {
      await _checkInternet();
    });
  }

  Future<void> _checkInternet() async {
    bool previousStatus = _isOnline;

    // First, check network type
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _isOnline = false;
    } else {
      // Then, ping a lightweight endpoint to confirm real internet
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
