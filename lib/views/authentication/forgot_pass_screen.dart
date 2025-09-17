import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/forgotPassword_ViewModel.dart';
import 'package:ziya_attendence_app/views/authentication/resetpass.dart';
import 'package:ziya_attendence_app/views/authentication/verifyotp.dart';
import 'package:ziya_attendence_app/widgets/loginPageWidgets/customTextfield.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _handleReset() async {
    if (!_formKey.currentState!.validate()) return;

    final vm = Provider.of<ForgotPasswordViewModel>(context, listen: false);
    final result = await vm.resetPassword(_emailController.text.trim());

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result["message"] ?? "Unknown error")),
    );

    if (result["success"]) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => OtpView(
                email: _emailController.text.trim(),
                onVerified: () {
                  return Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ResetPasswordView(
                            email: _emailController.text.trim(),
                          ),
                    ),
                  );
                },
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ForgotPasswordViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Text(
                  TextConstants.forgotPassword,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  TextConstants.forgotSubText,
                  style: TextStyle(fontSize: 14.sp, color: AppColors.lightText),
                ),
                SizedBox(height: 70.h),

                /// Email Input
                CustomTextField(
                  label: TextConstants.email,
                  hint: TextConstants.emailAddres,
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Enter email";
                    return null;
                  },
                ),
                SizedBox(height: 32.h),

                /// Send Code Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 2,
                    ),
                    onPressed: vm.isLoading ? null : _handleReset,
                    child:
                        vm.isLoading
                            ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
                              TextConstants.sandCode,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 24.h),

                /// Back to login
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      TextConstants.backtologin,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.customGreen,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.customGreen,
                        decorationThickness: 0.8,
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
