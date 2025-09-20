// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ziya_attendence_app/constants/text_constants.dart';
// import 'package:ziya_attendence_app/constants/color_constants.dart';
// import '../../providers/checkin_card_controller.dart';
// import '../../providers/dashboard_controllers/check_face_verification_controller.dart';
// import '../../viewModels/auth_view_models/login_viewmodel.dart';
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
//     final loginVm = Provider.of<LoginViewModel>(context, listen: false);
//     final userId = loginVm.userId; // ✅ Correct userId from LoginViewModel

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

//       // Background update
//       Future(() async {
//         widget.isCheckIn
//             ? await attendanceProvider.checkIn()
//             : await attendanceProvider.checkOut();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Face verification failed ❌")),
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
// views/check_verification_screen.dart
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/viewModels/check-in-out_section_viewModel/check_face_verification_viewmodel.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';
import '../../providers/checkin_card_controller.dart';
import '../../viewModels/auth_view_models/login_viewmodel.dart';
import 'punch_in_out_success_screen.dart';

class CheckVerificationScreen extends StatefulWidget {
  final bool isCheckIn;

  const CheckVerificationScreen({super.key, required this.isCheckIn});

  @override
  State<CheckVerificationScreen> createState() =>
      _CheckVerificationScreenState();
}

class _CheckVerificationScreenState extends State<CheckVerificationScreen> {
  late CheckFaceVerificationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CheckFaceVerificationViewModel();
    viewModel.initCamera();
  }

  @override
  void dispose() {
    viewModel.disposeCamera();
    viewModel.dispose();
    super.dispose();
  }

  // Future<void> _captureAndVerify(BuildContext context) async {
  //   final loginVm = Provider.of<LoginViewModel>(context, listen: false);
  //   final userId = loginVm.userId;

  //   if (userId == null) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text("User not logged in!")));
  //     return;
  //   }

  //   File? image = await viewModel.captureImage();
  //   if (image == null) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text("Failed to capture image!")));
  //     return;
  //   }

  //   final result = await viewModel.verifyFace(image, userId);

  //   final attendanceProvider = Provider.of<AttendanceProvider>(
  //     context,
  //     listen: false,
  //   );

  //   if (result.success) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder:
  //             (_) => PunchInOutSuccessScreen(
  //               checkedIn: widget.isCheckIn,
  //               time:
  //                   widget.isCheckIn
  //                       ? attendanceProvider.checkInTime!
  //                       : attendanceProvider.checkOutTime!,
  //             ),
  //       ),
  //     );

  //     Future(() async {
  //       widget.isCheckIn
  //           ? await attendanceProvider.checkIn()
  //           : await attendanceProvider.checkOut();
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(result.message ?? "Face verification failed ❌")),
  //     );
  //   }
  // }
  Future<void> _captureAndVerify(BuildContext context) async {
    final loginVm = Provider.of<LoginViewModel>(context, listen: false);
    final userId = loginVm.userId;

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("⚠️ User not logged in!")));
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Capture image
      final image = await viewModel.captureImage();
      if (image == null) {
        if (Navigator.canPop(context)) Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Failed to capture image!")),
        );
        return;
      }

      // Call provider → should ideally be a ViewModel instead
      final attendanceProvider = Provider.of<AttendanceProvider>(
        context,
        listen: false,
      );

      final result = await attendanceProvider.verifyFaceAndCheck(
        userId: userId,
        imageFile: image,
        checkInMode: widget.isCheckIn,
      );

      if (Navigator.canPop(context)) Navigator.pop(context);

      if (result.success) {
        // Navigate on success
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message ?? "Face verification failed ❌"),
          ),
        );
      }
    } catch (e) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("⚠️ Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckFaceVerificationViewModel>.value(
      value: viewModel,
      child: Consumer<CheckFaceVerificationViewModel>(
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
                Positioned.fill(
                  child: CameraPreview(provider.cameraController!),
                ),
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
