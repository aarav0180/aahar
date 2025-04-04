import 'package:flutter/material.dart';
import 'package:work_ai/view/widgets/footer/bottomNav/bottom_nav.dart';
import '../../../../core/data/auth/auth_storage.dart';
import '../../../widgets/custom_buttons/custom_button.dart';
import '../../../widgets/custom_buttons/logos/apple_login.dart';
import '../../../widgets/custom_buttons/logos/facebook_login.dart';
import '../../../widgets/custom_buttons/logos/google_login.dart';
import '../../../widgets/custom_widgets/text_field/custom_text_widget.dart';
import '../../../widgets/custom_widgets/logo/logo_widget.dart';
import '../../../widgets/theme/theme_button.dart';
import '../signup/signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    if (_usernameController.text.isNotEmpty) {
      await AuthStorage.saveUser(_usernameController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: isDarkMode
                        ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 20)]
                        : [BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 10)],
                  ),
                  child: const LogoWidget(height: 120),
                ),
                const SizedBox(height: 25),

                // Welcome Back Text
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Login to continue",
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 25),

                // Card-Like Login Form
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      if (!isDarkMode)
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomTextField(hintText: "Email Address", controller: _usernameController,),
                      const SizedBox(height: 12),
                      CustomTextField(hintText: "Password", isPassword: true, controller: passwordController),
                      const SizedBox(height: 8),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {

                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      PrimaryButton(text: "Continue", onPressed: _login),
                      const SizedBox(height: 15),

                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupPage()),
                        ),
                        child: const Text(
                          "Don't have an account? Sign up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(child: Divider(color: isDarkMode ? Colors.white38 : Colors.black26)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or",
                        style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                    ),
                    Expanded(child: Divider(color: isDarkMode ? Colors.white38 : Colors.black26)),
                  ],
                ),
                const SizedBox(height: 20),

                // Social Login Buttons
                Column(
                  children: [
                    GoogleLoginButton(onPressed: () {}),
                    const SizedBox(height: 12),
                    FacebookLoginButton(onPressed: () {}),
                    const SizedBox(height: 12),
                    AppleLoginButton(onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: const ThemeToggleButton(),
    );
  }
}
