import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/views/bottom_navigationBar.dart';

class AccountVerifiedScreen extends StatefulWidget {
  const AccountVerifiedScreen({super.key});

  @override
  State<AccountVerifiedScreen> createState() => _AccountVerifiedScreenState();
}

class _AccountVerifiedScreenState extends State<AccountVerifiedScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Stars + Check Icon
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/Stars.png",
                  width: 250.w,
                  height: 250.h,
                  fit: BoxFit.contain,
                ),

                Positioned(
                  bottom: 20.h,
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: const BoxDecoration(
                      color: AppColors.successGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 60.sp,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// Title
            Text(
              TextConstants.accountVerified,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.acVerifiedClr,
              ),
            ),

            SizedBox(height: 8.h),

            /// Description
            Text(
              TextConstants.accountVerifiedMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.acVerifiedMsgClr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
