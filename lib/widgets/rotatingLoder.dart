import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';

class RotatingLoaderScreen extends StatefulWidget {
  const RotatingLoaderScreen({super.key});

  @override
  State<RotatingLoaderScreen> createState() => _RotatingLoaderScreenState();
}

class _RotatingLoaderScreenState extends State<RotatingLoaderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static const double _size = 120;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: _size,
          height: _size,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return CustomPaint(
                painter: _RotatingAnimation(rotation: _controller.value),
                child: Center(
                  child: RotationTransition(
                    turns: _controller,
                    child: Image.asset(
                      TextConstants.ziyaLogo,
                      width: _size * 0.7,
                      height: _size * 0.7,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RotatingAnimation extends CustomPainter {
  final double rotation;

  _RotatingAnimation({required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 6.0;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 1.3;

    final Rect rect = Rect.fromCircle(center: center, radius: radius);
    const Color baseColor = Color(0xFF9B7EDC);

    final Paint paint =
        Paint()
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..shader = SweepGradient(
            startAngle: 0,
            endAngle: 2 * pi,
            tileMode: TileMode.clamp,
            colors: [
              const Color(0xFFE3D5FF),
              const Color(0xFFB49AE0),
              baseColor,
              baseColor,
              baseColor.withOpacity(0.6),
              baseColor.withOpacity(0.2),
              baseColor.withOpacity(0.0),
            ],
            stops: const [0.0, 0.05, 0.15, 0.5, 0.8, 0.95, 1.0],
            transform: GradientRotation(2 * pi * rotation),
          ).createShader(rect);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _RotatingAnimation oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}
