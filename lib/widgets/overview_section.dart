import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  Widget _buildCard(String label, String count, Color color, Color labelColor) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(color: labelColor, fontSize: 14.sp)),
            SizedBox(height: 20.h),
            Text(
              count,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCard(
          TextConstants.presence,
          TextConstants.presenceLength,
          AppColors.presenceClr,
          AppColors.presenceClr,
        ),
        SizedBox(width: 4.2.w),
        _buildCard(
          TextConstants.absence,
          TextConstants.absenceLength,
          AppColors.absenceClr,
          AppColors.absenceClr,
        ),
        SizedBox(width: 4.2.w),
        _buildCard(
          TextConstants.leaves,
          TextConstants.leavesLength,
          AppColors.leavesClr,
          AppColors.leavesClr,
        ),
      ],
    );
  }
}
