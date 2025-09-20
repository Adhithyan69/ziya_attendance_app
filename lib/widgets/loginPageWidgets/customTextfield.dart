import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/validator.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? togglePassword;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.togglePassword,
    this.validator,
  });

  String? _defaultValidator(String? value) {
    if (label.toLowerCase().contains("email")) {
      return Validator.email(value, label: label);
    } else if (isPassword || label.toLowerCase().contains("password")) {
      return Validator.password(value, label: label);
    } else if (label.toLowerCase().contains("name")) {
      return Validator.name(value, label: label);
    } else if (label.toLowerCase().contains("phone") ||
        label.toLowerCase().contains("mobile")) {
      return Validator.phone(value, label: label);
    }

    value = value?.trim();
    if (value == null || value.isEmpty) return "⚠ Please enter $label";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) => (validator ?? _defaultValidator)(controller.text),
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Label
            Padding(
              padding: EdgeInsets.only(left: 4.w, bottom: 6.h),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
              ),
            ),

            Material(
              elevation: 5,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(12.r),
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                style: TextStyle(fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  prefixIcon: Icon(icon, color: Colors.grey, size: 22.sp),
                  suffixIcon:
                      isPassword
                          ? IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                              size: 22.sp,
                            ),
                            onPressed: togglePassword,
                          )
                          : null,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 18.h,
                    horizontal: 16.w,
                  ),
                  border: InputBorder.none,
                  errorStyle: TextStyle(height: 0, fontSize: 0.sp),
                ),
                onChanged: field.didChange,
              ),
            ),

            /// Error Text
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(top: 6.h, left: 6.w),
                child: Text(
                  field.errorText!,
                  style: TextStyle(fontSize: 13.sp, color: Colors.red),
                ),
              ),

            SizedBox(height: 14.h),
          ],
        );
      },
    );
  }
}
