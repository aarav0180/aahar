import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with SingleTickerProviderStateMixin {
  int activeDot = 0;
  late AnimationController _controller;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Loop the animation

    // Define blinking animation
    _blinkAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add navigation for skipping
                  },
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF32CD32),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Reduced space here
              _buildContentBox(), // Updated content box
              const Spacer(flex: 2),
              _buildLoginButton(
                context,
                icon: Icons.g_mobiledata_rounded,
                text: 'Continue with Google',
                onTap: () {},
              ),
              const SizedBox(height: 15),
              _buildLoginButton(
                context,
                icon: Icons.apple,
                text: 'Continue with Apple',
                onTap: () {},
              ),
              const SizedBox(height: 15),
              _buildLoginButton(
                context,
                icon: Icons.code,
                text: 'Continue with GitHub',
                onTap: () {},
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++) _animatedDot(isActive: i == activeDot),
      ],
    );
  }

  Widget _animatedDot({required bool isActive}) {
    return AnimatedBuilder(
      animation: _blinkAnimation,
      builder: (context, child) {
        return Container(
          width: 18,
          height: 18,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isActive
                ? Color.lerp(
                const Color(0xFF6C63FF), const Color(0xFF1A1A2E), _blinkAnimation.value)
                : const Color(0xFF555555),
            borderRadius: BorderRadius.circular(15),
          ),
        );
      },
    );
  }

  Widget _buildContentBox() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white, // ShaderMask applies gradient here
                  width: 1.5,
                ),
              ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20, bottom: 80, top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIndicator(), // Dots at the top, aligned inside the box
                  const SizedBox(height: 20),
                  _buildAnimatedMemoText(),
                  const SizedBox(height: 10),
                  Text(
                    '# Welcome',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6C63FF),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You are in the right place to become a better developer. ',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.5, // Adjust line height for readability
                    ),
                    softWrap: true, // Enables dynamic wrapping
                    textAlign: TextAlign.start, // Aligns text to the left
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'We use spaced repetition to accelerate your learning.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.5, // Adjust line height for readability
                    ),
                    softWrap: true, // Enables dynamic wrapping
                    textAlign: TextAlign.start, // Aligns text to the left
                  ),
                ],
              ),
            ),
            ),
        ),
        // Inner fading gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent, // Fully transparent at the top
                  const Color(0xFF1A1A2E), // Background color to fade into
                ],
                stops: [0.7, 1.0],
              ),
            ),
          ),
        ),
        // Inner content with dots and text
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       _buildIndicator(), // Dots at the top, aligned inside the box
        //       const SizedBox(height: 20),
        //       _buildAnimatedMemoText(),
        //       const SizedBox(height: 10),
        //       Text(
        //         '# Welcome',
        //         style: GoogleFonts.poppins(
        //           fontSize: 18,
        //           fontWeight: FontWeight.w500,
        //           color: const Color(0xFF6C63FF),
        //         ),
        //       ),
        //       const SizedBox(height: 10),
        //       Text(
        //         'You are in the right place to become a better developer. ',
        //         style: GoogleFonts.poppins(
        //           fontSize: 16,
        //           fontWeight: FontWeight.w400,
        //           color: Colors.white,
        //           height: 1.5, // Adjust line height for readability
        //         ),
        //         softWrap: true, // Enables dynamic wrapping
        //         textAlign: TextAlign.start, // Aligns text to the left
        //       ),
        //       const SizedBox(height: 10),
        //       Text(
        //         'We use spaced repetition to accelerate your learning.',
        //         style: GoogleFonts.poppins(
        //           fontSize: 16,
        //           fontWeight: FontWeight.w400,
        //           color: Colors.white,
        //           height: 1.5, // Adjust line height for readability
        //         ),
        //         softWrap: true, // Enables dynamic wrapping
        //         textAlign: TextAlign.start, // Aligns text to the left
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }




  Widget _buildAnimatedMemoText() {
    return Row(
      children: [
        Text(
          'AlgoBloom',
          style: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        AnimatedBuilder(
          animation: _blinkAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _blinkAnimation.value,
              child: Container(
                width: 8,
                height: 48,
                color: const Color(0xFF6C63FF),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context,
      {required IconData icon, required String text, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 34, color: Colors.black),
      label: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDBCFFD),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    );
  }
}
