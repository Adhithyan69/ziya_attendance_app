import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          TextConstants.appTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 37.sp, // ✅ responsive with screenutil
            fontWeight: FontWeight.bold,
            color: AppColors.blue,
          ),
        ),
        SizedBox(height: 4.h), // ✅ responsive spacing
        Text(
          TextConstants.appTagline,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp, // ✅ responsive
            color: AppColors.customGreen,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
