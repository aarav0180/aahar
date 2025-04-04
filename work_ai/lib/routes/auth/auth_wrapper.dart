import 'package:flutter/material.dart';
import 'package:work_ai/view/widgets/footer/bottomNav/bottom_nav.dart';
import '../../core/data/auth/auth_storage.dart';
import '../../view/screens/auth/login/login_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    String? storedUser = await AuthStorage.getUser();
    setState(() {
      _username = storedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _username == null ? const LoginPage() : const BottomNavBar();
  }
}
