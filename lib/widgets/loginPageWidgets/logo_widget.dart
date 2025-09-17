import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';

class LogoWidget extends StatelessWidget {
  final double? maxWidth;
  final double? maxHeight;
  final BoxFit fit;
  const LogoWidget({
    super.key,
    this.maxWidth,
    this.maxHeight,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    // Use ScreenUtil instead of MediaQuery
    final targetWidth = (maxWidth ?? (0.4.sw)).clamp(100.w, 500.w);

    return SizedBox(
      width: targetWidth,
      height: maxHeight ?? (targetWidth * 1.1), // keep same ratio
      child: Container(
        padding: EdgeInsets.all(8.w), // responsive padding
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.0),
          borderRadius: BorderRadius.circular(12.r), // responsive radius
        ),
        child: Image.asset(
          'assets/logo_image.jpg',
          fit: fit,
          errorBuilder:
              (context, error, stackTrace) => Center(
                child: Text(
                  TextConstants.logoError,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp), // responsive text
                ),
              ),
        ),
      ),
    );
  }
}
