import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/checkin_card_controller.dart';
import 'package:ziya_attendence_app/views/check-in-out_section/face_Reminder.screen.dart';
import 'package:ziya_attendence_app/views/check-in-out_section/qr_reminder_screen.dart';

class CheckOutDialog extends StatelessWidget {
  const CheckOutDialog({super.key});

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
            Icon(
              Icons.warning_amber_rounded,
              size: 48.sp,
              color: AppColors.orange,
            ),
            SizedBox(height: 16.h),
            Text(
              TextConstants.doYouReallyWantToCheckout,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                // Update task button
                Expanded(
                  child: _dialogButton(
                    label: TextConstants.updateTask,
                    color: AppColors.white,
                    textColor: AppColors.black,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: 12.w),

                // Punch out button
                Expanded(
                  child: _dialogButton(
                    label: TextConstants.punchOut,
                    color: Colors.blue,
                    textColor: AppColors.selectedTextColor,
                    onTap: () {
                      Navigator.pop(context);

                      if (provider.isOnsite) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => const QrReminderScreen(
                                  time: '',
                                  checkedIn: false,
                                ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    const FaceReminderScreen(isCheckIn: false),
                          ),
                        );
                      }
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

  Widget _dialogButton({
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
