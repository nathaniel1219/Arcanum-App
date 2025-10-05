import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthController extends ChangeNotifier {
  static final AuthController _instance = AuthController._internal();
  factory AuthController() => _instance;
  AuthController._internal();

  User? currentUser;
  String? authToken;

  // Login via API
  Future<void> login(String email, String password) async {
    final data = await ApiService.login(email, password);

    authToken = data['access_token']; // backend token
    final userData = data['user'];
    currentUser = User.fromJson(userData); // use fromJson
    notifyListeners();
  }

  // Register via API
  Future<void> register(String name, String email, String password, String passwordConfirmation) async {
    final data = await ApiService.register(name, email, password, passwordConfirmation);

    authToken = data['access_token'];
    final userData = data['user'];
    currentUser = User.fromJson(userData);
    notifyListeners();
  }

  // Logout
  Future<void> logout() async {
    // Optional: call backend /api/logout
    currentUser = null;
    authToken = null;
    notifyListeners();
  }

  bool isLoggedIn() => currentUser != null;
}
