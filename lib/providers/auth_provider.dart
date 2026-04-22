import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _userName = "Guest";
  String _userRole = "User";

  String get userName => _userName;
  String get userRole => _userRole;

  void login(String name, String role) {
    _userName = name;
    _userRole = role;
    notifyListeners();
  }

  void logout() {
    _userName = "Guest";
    _userRole = "User";
    notifyListeners();
  }
}