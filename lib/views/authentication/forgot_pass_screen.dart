import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/auth_controllers/forgot_controller.dart';
import 'package:ziya_attendence_app/views/authentication/resetpass.dart';
import 'package:ziya_attendence_app/views/authentication/verifyotp.dart';
import '../../widgets/background_circles_widget.dart';
import '../../widgets/login_textFields.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundCircles(),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Text(
                        TextConstants.appTitle,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      Text(
                        TextConstants.fotgotPassword,
                        style: TextStyle(color: Colors.green, fontSize: 18.sp),
                      ),
                      SizedBox(height: 32.h),

                      LoginTextFields(
                        controller: emailController,
                        hint: TextConstants.enterYourEmail,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return TextConstants.emailIsRequired;
                          }
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return TextConstants.enterValidEmail;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24.h),

                      Consumer<ForgotPasswordProvider>(
                        builder: (context, provider, _) {
                          return SizedBox(
                            width: double.infinity,
                            height: 48.h,
                            child: ElevatedButton(
                              onPressed:
                                  provider.isLoading
                                      ? null
                                      : () async {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          final success = await provider
                                              .resetPassword(
                                                context: context,
                                                email: emailController.text,
                                              );

                                          if (success) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => OtpScreen(
                                                      email:
                                                          emailController.text,
                                                      onVerified:
                                                          () => Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    _,
                                                                  ) => ResetPasswordScreen(
                                                                    email:
                                                                        emailController
                                                                            .text,
                                                                  ),
                                                            ),
                                                          ),
                                                    ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child:
                                  provider.isLoading
                                      ? SizedBox(
                                        width: 20.w,
                                        height: 20.w,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                      : Text(
                                        TextConstants.resetPassword,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 12.h),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          TextConstants.backToLogin,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
