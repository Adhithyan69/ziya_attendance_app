import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';

class BufferingScreen extends StatefulWidget {
  const BufferingScreen({super.key});

  @override
  State<BufferingScreen> createState() => _BufferingScreenState();
}

class _BufferingScreenState extends State<BufferingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
      backgroundColor: AppColors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Rotating Gradient Ring
            RotationTransition(
              turns: _controller,
              child: CustomPaint(
                size: Size(100.w, 100.w),
                painter: LoaderPainter(),
              ),
            ),

            /// Center Logo
            Image.asset(TextConstants.ziyaLogo, width: 90.w, height: 90.w),
          ],
        ),
      ),
    );
  }
}

class LoaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      colors: [
        AppColors.loaderRingClr,
        AppColors.loaderRingClr.withOpacity(0.0),
      ],
    );

    final paint =
        Paint()
          ..strokeWidth = 6.w
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..shader = gradient.createShader(rect);

    const sweepAngle = pi * 1.8;

    canvas.drawArc(rect, 0, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
