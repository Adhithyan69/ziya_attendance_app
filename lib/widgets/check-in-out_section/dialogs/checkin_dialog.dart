import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/checkin_card_controller.dart';
import 'package:ziya_attendence_app/views/check-in-out_section/face_Reminder.screen.dart';
import 'package:ziya_attendence_app/views/check-in-out_section/qr_reminder_screen.dart';

class CheckInDialog extends StatelessWidget {
  const CheckInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context, listen: false);

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _closeButton(context),
            SizedBox(height: 8.h),
            Text(
              TextConstants.selectPunchInType,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Text(
              TextConstants.punchInDialog,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: _optionButton(
                    label: TextConstants.onSite,
                    color: AppColors.white,
                    textColor: AppColors.black,
                    onTap: () {
                      provider.setWorkMode(true);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => const QrReminderScreen(
                                time: '',
                                checkedIn: true,
                              ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _optionButton(
                    label: TextConstants.wfh,
                    color: AppColors.blue,
                    textColor: AppColors.selectedTextColor,
                    onTap: () {
                      provider.setWorkMode(false);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => const FaceReminderScreen(isCheckIn: true),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _closeButton(BuildContext context) => Align(
    alignment: Alignment.topRight,
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(Icons.close, color: AppColors.grey, size: 22.sp),
    ),
  );

  Widget _optionButton({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) => ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
    child: Text(label, style: TextStyle(color: textColor, fontSize: 14.sp)),
  );
}
