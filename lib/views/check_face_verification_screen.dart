// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ziya_attendence_app/constants/text_constants.dart';
// import 'package:ziya_attendence_app/constants/color_constants.dart';
// import '../providers/auth_controllers/login_controller.dart';
// import '../providers/checkin_card_controller.dart';
// import '../providers/dashboard_controllers/check_face_verification_controller.dart';
// import 'punch_in_out_success_screen.dart';

// class CheckVerificationScreen extends StatefulWidget {
//   final bool isCheckIn;

//   const CheckVerificationScreen({super.key, required this.isCheckIn});

//   @override
//   State<CheckVerificationScreen> createState() =>
//       _CheckVerificationScreenState();
// }

// class _CheckVerificationScreenState extends State<CheckVerificationScreen> {
//   late CheckFaceVerificationController faceProvider;

//   @override
//   void initState() {
//     super.initState();
//     faceProvider = CheckFaceVerificationController();
//   }

//   @override
//   void dispose() {
//     faceProvider.disposeCamera();
//     faceProvider.dispose();
//     super.dispose();
//   }

//   Future<void> _captureAndVerify(BuildContext context) async {
//     final loginProvider = Provider.of<LoginProvider>(context, listen: false);
//     final userId = loginProvider.userData?['id'];

//     if (userId == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("User not logged in!")));
//       return;
//     }

//     File? image = await faceProvider.captureImage();
//     if (image == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Failed to capture image!")));
//       return;
//     }

//     faceProvider.isLoading = true;
//     faceProvider.notifyListeners();

//     bool success = await faceProvider.verifyFaceAndMarkAttendance(
//       context,
//       image,
//       userId,
//     );

//     faceProvider.isLoading = false;
//     faceProvider.notifyListeners();

//     final attendanceProvider = Provider.of<AttendanceProvider>(
//       context,
//       listen: false,
//     );

//     if (success) {
//       if (widget.isCheckIn) {
//         attendanceProvider.checkIn();
//       } else {
//         attendanceProvider.checkOut();
//       }

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder:
//               (_) => PunchInOutSuccessScreen(
//                 checkedIn: widget.isCheckIn,
//                 time:
//                     widget.isCheckIn
//                         ? attendanceProvider.checkInTime!
//                         : attendanceProvider.checkOutTime!,
//               ),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Face verification failed!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<CheckFaceVerificationController>.value(
//       value: faceProvider,
//       child: Consumer<CheckFaceVerificationController>(
//         builder: (context, provider, child) {
//           if (provider.cameraController == null ||
//               !provider.cameraController!.value.isInitialized) {
//             return const Scaffold(
//               backgroundColor: Colors.black,
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           return Scaffold(
//             backgroundColor: AppColors.background,
//             body: Stack(
//               children: [
//                 // Camera Preview
//                 Positioned.fill(
//                   child: CameraPreview(provider.cameraController!),
//                 ),

//                 // Center guide text
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 220.h),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           TextConstants.centerYourFace,
//                           style: TextStyle(
//                             color: AppColors.black,
//                             fontSize: 24.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           TextConstants.checkVerifcnText,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: AppColors.lightText,
//                             fontSize: 15.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Bottom buttons area
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     height: 250.h,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [Colors.transparent, AppColors.buttonColor],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                     child:
//                         provider.isLoading
//                             ? Center(
//                               child: CircularProgressIndicator(
//                                 color: AppColors.selectedTextColor,
//                               ),
//                             )
//                             : Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Flash toggle
//                                 CircleAvatar(
//                                   backgroundColor: AppColors.selectedTextColor,
//                                   radius: 20.r,
//                                   child: IconButton(
//                                     icon: Icon(
//                                       provider.isFlashOn
//                                           ? Icons.flash_on
//                                           : Icons.flash_off,
//                                       color: AppColors.unSelectedTextColor,
//                                       size: 25.sp,
//                                     ),
//                                     onPressed: provider.toggleFlash,
//                                   ),
//                                 ),
//                                 SizedBox(width: 25.w),

//                                 // Capture button
//                                 GestureDetector(
//                                   onTap: () => _captureAndVerify(context),
//                                   child: CircleAvatar(
//                                     backgroundColor: AppColors.buttonColor,
//                                     radius: 45.r,
//                                     child: Icon(
//                                       Icons.check,
//                                       color: AppColors.selectedTextColor,
//                                       size: 60.sp,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 25.w),

//                                 // Switch camera
//                                 CircleAvatar(
//                                   backgroundColor: AppColors.selectedTextColor,
//                                   radius: 20.r,
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.cameraswitch,
//                                       color: AppColors.unSelectedTextColor,
//                                       size: 25.sp,
//                                     ),
//                                     onPressed: provider.switchCamera,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import '../providers/auth_controllers/login_controller.dart';
import '../providers/checkin_card_controller.dart';
import '../providers/dashboard_controllers/check_face_verification_controller.dart';
import 'punch_in_out_success_screen.dart';

class CheckVerificationScreen extends StatefulWidget {
  final bool isCheckIn;

  const CheckVerificationScreen({super.key, required this.isCheckIn});

  @override
  State<CheckVerificationScreen> createState() =>
      _CheckVerificationScreenState();
}

class _CheckVerificationScreenState extends State<CheckVerificationScreen> {
  late CheckFaceVerificationController faceProvider;

  @override
  void initState() {
    super.initState();
    faceProvider = CheckFaceVerificationController();
  }

  @override
  void dispose() {
    faceProvider.disposeCamera();
    faceProvider.dispose();
    super.dispose();
  }

  Future<void> _captureAndVerify(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final userId = loginProvider.userData?['id'];

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User not logged in!")));
      return;
    }

    File? image = await faceProvider.captureImage();
    if (image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to capture image!")));
      return;
    }

    faceProvider.isLoading = true;
    faceProvider.notifyListeners();

    bool success = await faceProvider.verifyFaceAndMarkAttendance(
      context,
      image,
      userId,
    );

    faceProvider.isLoading = false;
    faceProvider.notifyListeners();

    final attendanceProvider = Provider.of<AttendanceProvider>(
      context,
      listen: false,
    );

    if (success) {
      // Navigate instantly with placeholder time
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) => PunchInOutSuccessScreen(
                checkedIn: widget.isCheckIn,
                time:
                    widget.isCheckIn
                        ? attendanceProvider.checkInTime!
                        : attendanceProvider.checkOutTime!,
              ),
        ),
      );

      // Update attendance in the background (async)
      Future(() async {
        final attendanceProvider = Provider.of<AttendanceProvider>(
          context,
          listen: false,
        );

        bool result =
            widget.isCheckIn
                ? await attendanceProvider.checkIn()
                : await attendanceProvider.checkOut();

        // Optionally, you can notify the next screen to update the time
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Face verification failed ❌")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckFaceVerificationController>.value(
      value: faceProvider,
      child: Consumer<CheckFaceVerificationController>(
        builder: (context, provider, child) {
          if (provider.cameraController == null ||
              !provider.cameraController!.value.isInitialized) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.background,
            body: Stack(
              children: [
                // Camera Preview
                Positioned.fill(
                  child: CameraPreview(provider.cameraController!),
                ),

                // Center guide text
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 220.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          TextConstants.centerYourFace,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          TextConstants.checkVerifcnText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.lightText,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom buttons area
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 250.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, AppColors.buttonColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child:
                        provider.isLoading
                            ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.selectedTextColor,
                              ),
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Flash toggle
                                CircleAvatar(
                                  backgroundColor: AppColors.selectedTextColor,
                                  radius: 20.r,
                                  child: IconButton(
                                    icon: Icon(
                                      provider.isFlashOn
                                          ? Icons.flash_on
                                          : Icons.flash_off,
                                      color: AppColors.unSelectedTextColor,
                                      size: 25.sp,
                                    ),
                                    onPressed: provider.toggleFlash,
                                  ),
                                ),
                                SizedBox(width: 25.w),

                                // Capture button
                                GestureDetector(
                                  onTap: () => _captureAndVerify(context),
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.buttonColor,
                                    radius: 45.r,
                                    child: Icon(
                                      Icons.check,
                                      color: AppColors.selectedTextColor,
                                      size: 60.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25.w),

                                // Switch camera
                                CircleAvatar(
                                  backgroundColor: AppColors.selectedTextColor,
                                  radius: 20.r,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.cameraswitch,
                                      color: AppColors.unSelectedTextColor,
                                      size: 25.sp,
                                    ),
                                    onPressed: provider.switchCamera,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
