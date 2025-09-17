import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/resetPassword_viewModel.dart';
import 'package:ziya_attendence_app/views/authentication/login_screen.dart';

class ResetPasswordView extends StatelessWidget {
  final String email;

  const ResetPasswordView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordViewModel(),
      child: Consumer<ResetPasswordViewModel>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Scaffold(
              backgroundColor: AppColors.white,
              body: Center(child: CircularProgressIndicator()),
            );
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

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            });
            return const Scaffold(backgroundColor: AppColors.white);
          }

          return Scaffold(
            backgroundColor: AppColors.resetBackgroundClr,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextConstants.createNewPassword,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      TextConstants.enterEmailToReset,
                      style: TextStyle(fontSize: 18.sp, color: AppColors.grey),
                    ),
                    SizedBox(height: 82.h),

                    // New Password Field
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

                    // Confirm Password Field
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
