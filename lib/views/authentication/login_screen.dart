import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/auth_controllers/login_controller.dart';
import 'package:ziya_attendence_app/views/authentication/account_verified_screen.dart';
import 'package:ziya_attendence_app/views/authentication/buffering_screen.dart';
import 'package:ziya_attendence_app/views/authentication/forgot_pass_screen.dart';
import 'package:ziya_attendence_app/views/bottom_navigationBar.dart';
import 'package:ziya_attendence_app/widgets/background_circles_widget.dart';
import 'package:ziya_attendence_app/widgets/login_textFields.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);

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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        TextConstants.loginToYOurAccount,
                        style: TextStyle(color: Colors.green, fontSize: 18.sp),
                      ),
                      SizedBox(height: 32.h),

                      LoginTextFields(
                        controller: emailController,
                        hint: TextConstants.emailHint,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return TextConstants.emailIsRequired;
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                          ).hasMatch(value)) {
                            return TextConstants.enterValidEmail;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),

                      LoginTextFields(
                        controller: passwordController,
                        hint: TextConstants.passwordHint,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return TextConstants.passwordIsRequired;
                          }
                          if (value.length < 6) {
                            return TextConstants.passwordMustBe6Char;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),

                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),

                          onPressed:
                              provider.isLoading
                                  ? null
                                  : () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Show buffering screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => const BufferingScreen(),
                                        ),
                                      );

                                      // Perform login
                                      final result = await provider.login(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      );

                                      // Remove buffering screen
                                      Navigator.pop(context);

                                      if (result["success"]) {
                                        // Show AccountVerifiedScreen
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) =>
                                                    const AccountVerifiedScreen(),
                                          ),
                                        );

                                        // Navigate to Home after short delay
                                        Future.delayed(
                                          const Duration(seconds: 2),
                                          () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) =>
                                                        const BottomNavigation(),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              result["message"] ??
                                                  "Login failed",
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },

                          child:
                              provider.isLoading
                                  ? SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : Text(
                                    TextConstants.login,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ForgotPasswordPage(),
                                  ),
                                ),
                            child: Text(
                              TextConstants.fotgotPassword,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
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
