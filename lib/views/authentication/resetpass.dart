import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/auth_controllers/reset_controller.dart';
import 'package:ziya_attendence_app/views/authentication/account_verified_screen.dart';
import 'package:ziya_attendence_app/views/authentication/buffering_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordController(),
      child: Consumer<ResetPasswordController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const PasswordResetLoader();
          }

          if (controller.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(TextConstants.resetSuccess),
                  backgroundColor: AppColors.resetSuccessClr,
                  behavior: SnackBarBehavior.floating,
                ),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const AccountVerifiedScreen(),
                ),
              );
            });

            return const PasswordResetLoader();
          }

          return Scaffold(
            backgroundColor: AppColors.resetBackgroundClr,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    Text(
                      TextConstants.createNewPassword,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    /// Description
                    Text(
                      TextConstants.enterEmailToReset,
                      style: TextStyle(fontSize: 18.sp, color: AppColors.grey),
                    ),
                    SizedBox(height: 82.h),

                    /// New Password Field
                    Card(
                      color: AppColors.white,
                      child: TextField(
                        obscureText: true,
                        onChanged: controller.onNewPasswordChanged,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.key_outlined, size: 20.sp),
                          hintText: TextConstants.newPassword,
                          hintStyle: TextStyle(fontSize: 14.sp),
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 12.w,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    /// Confirm Password Field
                    Card(
                      color: AppColors.white,
                      child: TextField(
                        obscureText: true,
                        onChanged: controller.onConfirmPasswordChanged,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.key_outlined, size: 20.sp),
                          hintText: TextConstants.confirmPassword,
                          hintStyle: TextStyle(fontSize: 14.sp),
                          filled: true,
                          fillColor: AppColors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 12.w,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    /// Error Message
                    if (controller.errorMessage != null) ...[
                      SizedBox(height: 16.h),
                      Text(
                        controller.errorMessage!,
                        style: TextStyle(
                          color: AppColors.absenceClr,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],

                    SizedBox(height: 32.h),

                    /// Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Cancel Button
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.resetCancelBtnClr,
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 16.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Text(
                            TextConstants.cancel,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        /// Reset Password Button
                        ElevatedButton(
                          onPressed: () {
                            controller.resetPassword(email);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.resetButtonClr,
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 16.w,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: Text(
                            TextConstants.resetPassword,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
