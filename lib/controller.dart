// lib/controllers/controller.dart

import '../models/user.dart';

class Controller {
  static final Controller _instance = Controller._internal();

  factory Controller() => _instance;

  Controller._internal();

  User? currentUser;

  void login(String email, String password) {
    currentUser = User(email: email, password: password);
  }

  void logout() {
    currentUser = null;
  }

  bool isLoggedIn() => currentUser != null;
}
