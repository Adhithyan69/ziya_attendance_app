import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/checkin_card_controller.dart';
import 'package:ziya_attendence_app/widgets/check-in-out_section/common/check-in-out_button.dart';
import 'dialogs/checkin_dialog.dart';
import 'dialogs/checkout_dialog.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context);

    return Card(
      color: Colors.blue.shade50.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusText(provider),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: CheckInOutButton(
                    label: TextConstants.punchIn,
                    icon: Icons.input,
                    enabled: !provider.isCheckedIn,
                    onTap:
                        () => showDialog(
                          context: context,
                          builder: (_) => const CheckInDialog(),
                        ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CheckInOutButton(
                    label: TextConstants.punchOut,
                    icon: Icons.output,
                    enabled: provider.isCheckedIn,
                    onTap:
                        () => showDialog(
                          context: context,
                          builder: (_) => const CheckOutDialog(),
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusText(AttendanceProvider provider) {
    if (provider.isCheckedIn) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"${TextConstants.checkedInAt} ${provider.checkInTime}"',
            style: TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 10.h),
          if (provider.location != null)
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.red, size: 18.sp),
                SizedBox(width: 4.w),
                Text(
                  "${provider.location!}/",
                  style: TextStyle(fontSize: 13.sp),
                ),
                if (provider.deviceIp != null)
                  Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      provider.deviceIp!,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ),
                Text(
                  provider.isOnsite
                      ? " (${TextConstants.onSite})"
                      : " (${TextConstants.remote})",
                  style: TextStyle(fontSize: 13.sp),
                ),
              ],
            ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"${TextConstants.haventCheckedText}"',
            style: TextStyle(color: Colors.red, fontSize: 16.sp),
          ),
          if (provider.checkOutTime != null) ...[
            SizedBox(height: 6.h),
            Text(
              ' ${TextConstants.checkedOutText}${provider.checkOutTime}',
              style: TextStyle(
                color: AppColors.leaveScreenTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      );
    }
  }
}
