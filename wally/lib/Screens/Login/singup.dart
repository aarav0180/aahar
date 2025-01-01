import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _glowAnimation =
        Tween<double>(begin: 1.0, end: 1.5).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
  }

  void validateInputs() {
    String name = nameController.text.trim(); // For signup
    String phone = phoneController.text.trim();

    // Phone Number Validation (Must be 10 digits for example)
    if (phone.isEmpty || phone.length != 10 || !RegExp(r'^\d+$').hasMatch(phone)) {
      showError("Please enter a valid 10-digit phone number");
      return;
    }

    // Name Validation (Signup only - ensure non-empty and alphanumeric)
    if (nameController != null && (name.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(name))) {
      showError("Please enter a valid name with only letters and spaces");
      return;
    }

    // If all validations pass
    showSuccess("Inputs are valid!");
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }


  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2F),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF2B3A67),
                    Color(0xFF0A1A2F),
                  ],
                  center: Alignment(0, -0.6),
                  radius: 1.5,
                ),
              ),
            ),
          ),
          // Signup UI Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated AURA WALL Logo
                Column(
                  children: [
                    ScaleTransition(
                      scale: _glowAnimation,
                      child: ShaderMask(
                        shaderCallback: (bounds) => const RadialGradient(
                          colors: [Color(0xFFFF6DD0), Color(0xFF00D2FF)],
                          center: Alignment.center,
                          radius: 1.2,
                        ).createShader(bounds),
                        child: Text(
                          "AURA",
                          style: GoogleFonts.poppins(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.blueAccent.withOpacity(0.8),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "WALL",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                        color: Colors.white70,
                        shadows: [
                          Shadow(
                            color: Colors.blue.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // Name Input Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1C2940),
                      hintText: "Enter your name",
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                      ),
                    ),
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Phone Number Input Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1C2940),
                      hintText: "Enter your phone number",
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.blueAccent,
                      ),
                    ),
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Signup Button
                ElevatedButton(
                  onPressed: () {
                    // Signup logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C2940),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    ),
                  ),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [
                          Color(0xFFFA8BFF),
                          Color(0xFF2BD2FF),
                          Color(0xFF2BFF88),
                        ],
                      ).createShader(bounds);
                    },
                    child: Text(
                      'Signup',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Already a User? Login Button
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: Text(
                    "Already a user? Login",
                    style: GoogleFonts.poppins(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                // Footer Text
                Text(
                  'Safe. Vibrant. Yours.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
