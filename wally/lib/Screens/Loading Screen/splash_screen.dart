import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Offset> tracePoints = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // Loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2F), // Vibrant background color
      body: Stack(
        children: [
          // Centered Glowing AURA text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Glow effect for "AURA"
                Text(
                  "AURA",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [Colors.red, Colors.yellow, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(Rect.fromLTWH(0, 0, 200, 50)),
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.8),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                // Glow effect for "WALL"
                Text(
                  "WALL",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.blue.withOpacity(0.5),
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Translucent trace and animated ball
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final angle = _controller.value * 2 * pi; // Rotation angle
              final radius = 120.0; // Orbit radius

              // Current ball position
              final x = size.width / 2 + radius * cos(angle);
              final y = size.height / 2 + radius * sin(angle);

              // Add trace points
              if (tracePoints.length > 50) {
                tracePoints.removeAt(0); // Limit trace length
              }
              tracePoints.add(Offset(x, y));

              return CustomPaint(
                painter: TracePainter(tracePoints),
                child: child,
              );
            },
            child: Container(),
          ),

          // Ball widget
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final angle = _controller.value * 2 * pi; // Rotation angle
              final radius = 120.0; // Orbit radius

              return Positioned(
                left: size.width / 2 + radius * cos(angle) - 10,
                top: size.height / 2 + radius * sin(angle) - 10,
                child: child!,
              );
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple, Colors.red, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TracePainter extends CustomPainter {
  final List<Offset> tracePoints;

  TracePainter(this.tracePoints);

  @override
  void paint(Canvas canvas, Size size) {
    if (tracePoints.length < 2) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..shader = LinearGradient(
        colors: [
          Colors.blue.withOpacity(0.4),
          Colors.purple.withOpacity(0.4),
          Colors.red.withOpacity(0.4),
          Colors.orange.withOpacity(0.4),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < tracePoints.length - 1; i++) {
      canvas.drawLine(tracePoints[i], tracePoints[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}