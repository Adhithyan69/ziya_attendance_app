import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'check_face_verification_screen.dart';

class FaceReminderScreen extends StatelessWidget {
  final bool isCheckIn;

  const FaceReminderScreen({super.key, required this.isCheckIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),

                // Title
                Text(
                  TextConstants.faceVerification,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.unSelectedTextColor,
                  ),
                ),
                SizedBox(height: 8.h),

                // Subtitle
                Text(
                  TextConstants.pleaseCaptureYourFace,
                  style: TextStyle(fontSize: 18.sp, color: AppColors.lightText),
                ),
                SizedBox(height: 92.h),

                // Face animation / image
                Center(
                  child: Container(
                    height: 220.h,
                    width: 180.w,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Image.asset(
                      TextConstants.faceScanAnimation,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 80.h),

                // Take photo button
                Center(
                  child: SizedBox(
                    width: 250.w,
                    height: 40.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CheckVerificationScreen(
                                  isCheckIn: isCheckIn,
                                ),
                          ),
                        );
                      },
                      child: Text(
                        TextConstants.takePhoto,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.selectedTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
