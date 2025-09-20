import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/login_viewmodel.dart';

class RememberMeRow extends StatelessWidget {
  final LoginViewModel vm;
  const RememberMeRow({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: vm.rememberMe,
          activeColor: AppColors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r), // responsive radius
          ),
          onChanged: (value) => vm.toggleRememberMe(value ?? false),
          materialTapTargetSize:
              MaterialTapTargetSize.shrinkWrap, // tighter fit
        ),
        Text(
          TextConstants.rememberMe,
          style: TextStyle(
            fontSize: 15.sp, // responsive font size
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
