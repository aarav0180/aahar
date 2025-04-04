import '../../models/user_model.dart';

class AuthRepository {
  Future<bool> login(UserModel user) async {
    await Future.delayed(const Duration(seconds: 2));
    return user.email == "test@example.com" && user.password == "password123";
  }

  Future<bool> signup(UserModel user) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}
