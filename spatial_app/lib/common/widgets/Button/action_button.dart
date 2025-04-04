import 'package:flutter/material.dart';
import 'package:spatial_app/core/theme/app_theme.dart';

class ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // ✅ Fixed matrix scale issue
    final matrix = Matrix4.identity();
    if (_isPressed) {
      matrix.scale(0.95);
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: matrix, // ✅ Applied fixed scaling
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.color.withOpacity(0.9),
              widget.color.withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.5),
              blurRadius: _isPressed ? 8 : 16,
              spreadRadius: _isPressed ? 1 : 4,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Glassmorphism effect
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.08),
                backgroundBlendMode: BlendMode.overlay,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 30,
                    spreadRadius: -5,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            ),
            // Button Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      size: 56,
                      color: context.whiteColor, // Icon in white color
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.label,
                      style: context.textTheme.titleMedium!.copyWith(
                        color: context.whiteColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
