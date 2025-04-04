import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models/user_model.dart';
import '../../core/repository/auth/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepo = AuthRepository();
  bool isLoading = false;
  bool isAuthenticated = false;

  AuthViewModel();


  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAuthenticated = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  Future<void> authenticate(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      UserModel user = UserModel(email: email, password: password);
      bool success = await _authRepo.login(user);

      if (success) {
        isAuthenticated = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
      } else {
        isAuthenticated = false;
      }
    } catch (error) {
      isAuthenticated = false;
      print("Authentication failed: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    isAuthenticated = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    notifyListeners();
  }
}
