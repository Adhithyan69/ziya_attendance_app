// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../constants/color_constants.dart';
// import '../constants/text_constants.dart';
// import '../providers/checkin_card_controller.dart';
// import '../views/face_Reminder.screen.dart';
// import '../views/qr_reminder_screen.dart';
// import '../views/punch_in_out_success_screen.dart';

// class CheckInCard extends StatelessWidget {
//   const CheckInCard({super.key});

//   void openCheckInDialog(BuildContext context) {
//     final provider = Provider.of<AttendanceProvider>(context, listen: false);

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (context) => Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: const Icon(Icons.close, color: AppColors.grey),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     TextConstants.selectPunchInType,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 12),
//                   const Text(
//                     TextConstants.punchInDialog,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             provider.setWorkMode(false); // Onsite
//                             Navigator.pop(context);
//                             // Navigate to QR for onsite
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (_) => QrReminderScreen(
//                                       time: '', // empty for now
//                                       checkedIn: false,
//                                     ),
//                               ),
//                             );
//                           },
// style: ElevatedButton.styleFrom(
//   padding: const EdgeInsets.symmetric(vertical: 14),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(8),
//   ),
// ),
//                           child: const Text(
//                             TextConstants.onSite,
//                             style: TextStyle(
//                               color: AppColors.unSelectedTextColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             provider.setWorkMode(true); // Remote/WFH
//                             Navigator.pop(context);
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder:
//                                     (_) => FaceReminderScreen(isCheckIn: true),
//                               ),
//                             );
//                           },
// style: ElevatedButton.styleFrom(
//   backgroundColor: AppColors.blue,
//   padding: const EdgeInsets.symmetric(vertical: 14),
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(8),
//   ),
// ),
//                           child: const Text(
//                             TextConstants.wfh,
//                             style: TextStyle(
//                               color: AppColors.selectedTextColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   void openCheckOutDialog(BuildContext context) {
//     final provider = Provider.of<AttendanceProvider>(context, listen: false);

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (context) => Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Align(
//                     alignment: Alignment.topRight,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: const Icon(Icons.close, color: AppColors.grey),
//                     ),
//                   ),
//                   const Icon(
//                     Icons.warning_amber_rounded,
//                     size: 48,
//                     color: AppColors.orange,
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     TextConstants.doYouReallyWantToCheckout,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColors.orange,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () => Navigator.pop(context),
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text(
//                             TextConstants.updateTask,
//                             style: TextStyle(
//                               color: AppColors.unSelectedTextColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.pop(context);

//                             final attendanceProvider =
//                                 Provider.of<AttendanceProvider>(
//                                   context,
//                                   listen: false,
//                                 );

//                             if (attendanceProvider.isOnsite) {
//                               // If onsite -> navigate to QR Reminder
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder:
//                                       (_) =>
//                                           FaceReminderScreen(isCheckIn: false),
//                                 ),
//                               );
//                             } else {
//                               // If remote -> navigate to Face Reminder
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder:
//                                       (_) => const QrReminderScreen(
//                                         time: '',
//                                         checkedIn: false,
//                                       ),
//                                 ),
//                               );
//                             }
//                           },

//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text(
//                             TextConstants.punchOut,
//                             style: TextStyle(
//                               color: AppColors.selectedTextColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AttendanceProvider>(context);

//     return Card(
//       color: Colors.blue.shade50.withOpacity(0.8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             provider.isCheckedIn
//                 ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${TextConstants.checkedInAt} ${provider.checkInTime}',
//                       style: TextStyle(
//                         color: AppColors.green,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Icon(Icons.alarm, color: AppColors.orange),
//                         const SizedBox(width: 5),
//                         Text(
//                           '${provider.checkInTime}_${DateFormat(TextConstants.checkInDateFormat).format(DateTime.now())}',
//                           style: TextStyle(color: AppColors.orange),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     provider.isOnsite
//                         ? Row(
//                           children: [
//                             const Icon(Icons.location_on, color: AppColors.red),
//                             const SizedBox(width: 5),
//                             const Text(
//                               TextConstants.remoteALocationText,
//                               style: TextStyle(color: AppColors.black),
//                             ),
//                             const Text(
//                               TextConstants.remoteAttendance,
//                               style: TextStyle(color: AppColors.black),
//                             ),
//                           ],
//                         )
//                         : const SizedBox.shrink(),
//                   ],
//                 )
//                 : Text(
//                   TextConstants.haventCheckedText,
//                   style: TextStyle(
//                     color: provider.isCheckedIn ? Colors.green : Colors.red,
//                   ),
//                 ),
//             if (provider.checkOutTime != null && !provider.isCheckedIn)
//               Text('${TextConstants.checkedOutText}${provider.checkOutTime}'),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       backgroundColor:
//                           provider.isCheckedIn
//                               ? AppColors.secondaryButton
//                               : AppColors.buttonColor,
//                     ),
//                     onPressed:
//                         provider.isCheckedIn
//                             ? null
//                             : () => openCheckInDialog(context),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Icon(Icons.input, size: 20, color: AppColors.white),
//                         Text(
//                           TextConstants.punchIn,
//                           style: TextStyle(color: AppColors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed:
//                         provider.isCheckedIn
//                             ? () => openCheckOutDialog(context)
//                             : null,
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       backgroundColor:
//                           provider.isCheckedIn
//                               ? AppColors.buttonColor
//                               : AppColors.secondaryButton,
//                     ),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Icon(Icons.output, size: 20, color: AppColors.white),
//                         Text(
//                           TextConstants.punchOut,
//                           style: TextStyle(color: AppColors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/providers/checkin_card_controller.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';
import '../views/face_Reminder.screen.dart';
import '../views/qr_reminder_screen.dart';

class CheckInCard extends StatelessWidget {
  const CheckInCard({super.key});

  void openCheckInDialog(BuildContext context) {
    final rootContext = context;

    showDialog(
      context: rootContext,
      barrierDismissible: false,
      builder:
          (dialogContext) => Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(dialogContext),
                      child: Icon(
                        Icons.close,
                        color: AppColors.grey,
                        size: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    TextConstants.selectPunchInType,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
                      // Onsite
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final provider = Provider.of<AttendanceProvider>(
                              rootContext,
                              listen: false,
                            );
                            provider.setWorkMode(true); // onsite
                            Navigator.pop(dialogContext);
                            Navigator.push(
                              rootContext,
                              MaterialPageRoute(
                                builder:
                                    (_) => QrReminderScreen(
                                      time: '',
                                      checkedIn: true,
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            TextConstants.onSite,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // WFH
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final provider = Provider.of<AttendanceProvider>(
                              rootContext,
                              listen: false,
                            );
                            provider.setWorkMode(false); // WFH
                            Navigator.pop(dialogContext);
                            Navigator.push(
                              rootContext,
                              MaterialPageRoute(
                                builder:
                                    (_) => FaceReminderScreen(isCheckIn: true),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            TextConstants.wfh,
                            style: TextStyle(
                              color: AppColors.selectedTextColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void openCheckOutDialog(BuildContext context) {
    final rootContext = context;

    showDialog(
      context: rootContext,
      barrierDismissible: false,
      builder:
          (dialogContext) => Dialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(dialogContext),
                      child: Icon(
                        Icons.close,
                        color: AppColors.grey,
                        size: 22.sp,
                      ),
                    ),
                  ),
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
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            TextConstants.updateTask,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final provider = Provider.of<AttendanceProvider>(
                              rootContext,
                              listen: false,
                            );
                            Navigator.pop(dialogContext);

                            if (provider.isOnsite) {
                              Navigator.push(
                                rootContext,
                                MaterialPageRoute(
                                  builder:
                                      (_) => QrReminderScreen(
                                        time: '',
                                        checkedIn: false,
                                      ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                rootContext,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          FaceReminderScreen(isCheckIn: false),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            TextConstants.punchOut,
                            style: TextStyle(
                              color: AppColors.selectedTextColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

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
            provider.isCheckedIn
                ? Column(
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
                          Icon(
                            Icons.location_on,
                            color: AppColors.red,
                            size: 18.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "${provider.location!}/",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          if (provider.deviceIp != null)
                            Row(
                              children: [
                                SizedBox(width: 4.w),
                                Text(
                                  provider.deviceIp!,
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              Text(
                                provider.isOnsite
                                    ? " (${TextConstants.onSite})"
                                    : " (${TextConstants.remote})",
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                )
                : Text(
                  TextConstants.haventCheckedText,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
            if (provider.checkOutTime != null && !provider.isCheckedIn)
              Text(
                '${TextConstants.checkedOutText}${provider.checkOutTime}',
                style: TextStyle(fontSize: 13.sp),
              ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        provider.isCheckedIn
                            ? null
                            : () => openCheckInDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          provider.isCheckedIn
                              ? AppColors.secondaryButton
                              : AppColors.buttonColor,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.input, size: 20.sp, color: AppColors.white),
                        Text(
                          TextConstants.punchIn,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        provider.isCheckedIn
                            ? () => openCheckOutDialog(context)
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          provider.isCheckedIn
                              ? AppColors.buttonColor
                              : AppColors.secondaryButton,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.output, size: 20.sp, color: AppColors.white),
                        Text(
                          TextConstants.punchOut,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
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
}
