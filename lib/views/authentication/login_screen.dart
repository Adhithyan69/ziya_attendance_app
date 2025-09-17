import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/constants/validator.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/login_viewmodel.dart';
import 'package:ziya_attendence_app/views/authentication/account_verified_screen.dart';
import 'package:ziya_attendence_app/views/authentication/buffering_screen.dart';
import 'package:ziya_attendence_app/views/authentication/forgot_pass_screen.dart';
import 'package:ziya_attendence_app/widgets/loginPageWidgets/customTextfield.dart';
import 'package:ziya_attendence_app/widgets/loginPageWidgets/login_title_widget.dart';
import 'package:ziya_attendence_app/widgets/loginPageWidgets/logo_widget.dart';
import 'package:ziya_attendence_app/widgets/loginPageWidgets/remember_me_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);
    final isLandscape = 1.sw > 1.sh;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isLandscape ? 0.6.sw : 500.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LogoWidget(),
                  SizedBox(height: 30.h),
                  const LoginTitle(),
                  SizedBox(height: 30.h),

                  /// Email Field
                  CustomTextField(
                    label: TextConstants.email,
                    hint: TextConstants.enterEmail,
                    icon: Icons.email,
                    controller: vm.emailCtrl,
                    validator: Validator.email,
                  ),
                  SizedBox(height: 18.h),

                  /// Password Field
                  CustomTextField(
                    label: TextConstants.password,
                    hint: TextConstants.enterPassword,
                    icon: Icons.lock,
                    controller: vm.passCtrl,
                    isPassword: true,
                    obscureText: vm.obscurePassword,
                    togglePassword: vm.togglePasswordVisibility,
                    validator: Validator.password,
                  ),
                  SizedBox(height: 10.h),

                  /// Remember Me Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RememberMeRow(vm: vm),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordView(),
                            ),
                          );
                        },
                        child: const Text(
                          TextConstants.forgotPassword,

                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.blue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ), // ✅ Fixed here

                  SizedBox(height: 30.h),

                  /// Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 45.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      onPressed:
                          vm.isLoading
                              ? null
                              : () async {
                                if (!_formKey.currentState!.validate()) return;

                                // Show Buffering screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const BufferingScreen(),
                                  ),
                                );

                                // Perform login
                                final result = await vm.login();

                                // Close Buffering screen
                                Navigator.pop(context);

                                if (!context.mounted) return;

                                if (result[TextConstants.success] == true) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => const AccountVerifiedScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        result[TextConstants.message] ??
                                            TextConstants.loginFailed,
                                      ),
                                    ),
                                  );
                                }
                              },
                      child:
                          vm.isLoading
                              ? SizedBox(
                                height: 22.w,
                                width: 22.w,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    AppColors.white,
                                  ),
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                TextConstants.login,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
