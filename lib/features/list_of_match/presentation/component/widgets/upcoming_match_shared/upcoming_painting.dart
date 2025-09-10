import 'package:flutter/cupertino.dart';

// --- NEW WIDGETS FOR THE ANGLED BACKGROUND ---

/// A reusable card widget that displays a two-color angled background.
class AngledCard extends StatelessWidget {
  final Widget child;
  final Color color1;
  final Color color2;
  final double angle;

   AngledCard({
    super.key,
    required this.child,
    required this.color1,
    required this.color2,
    this.angle = 0.2, // Controls the steepness of the angle
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          // The custom painter is placed in the background
          Positioned.fill(
            child: CustomPaint(
              painter: AngledBackgroundPainter(
                color1: color1,
                color2: color2,
                angle: angle,
              ),
            ),
          ),
          // Your content is placed on top
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

/// A custom painter that draws two colored polygons to create an angled background.
class AngledBackgroundPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final double angle;

  AngledBackgroundPainter({
    required this.color1,
    required this.color2,
    required this.angle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = color1;
    final paint2 = Paint()..color = color2;

    // Draw the second color (right side) to cover the whole area first
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint2);

    // Create the path for the first color's shape (left side)
    final path = Path();
    path.moveTo(0, 0); // Top-left
    path.lineTo(size.width * (0.5 + angle), 0); // Top-right of the shape
    path.lineTo(
      size.width * (0.5 - angle),
      size.height,
    ); // Bottom-right of the shape (angled)
    path.lineTo(0, size.height); // Bottom-left
    path.close();

    // Draw the angled shape on top
    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(covariant AngledBackgroundPainter oldDelegate) {
    return oldDelegate.color1 != color1 ||
           oldDelegate.color2 != color2 ||
           oldDelegate.angle != angle;
  }
}
