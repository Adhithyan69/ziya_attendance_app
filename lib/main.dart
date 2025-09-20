import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/check_face_verification_controller.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/holiday_controller.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/leave_dashboard_controller.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/leave_status_controller.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/leaves_Request_controller.dart';
import 'package:ziya_attendence_app/providers/notification_controller.dart';
import 'package:ziya_attendence_app/providers/profile_controller.dart';
import 'package:ziya_attendence_app/providers/search_controller.dart';
import 'package:ziya_attendence_app/providers/task_controller.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/forgotPassword_ViewModel.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/login_viewmodel.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/otp_viewmodel.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/resetPassword_viewModel.dart';
import 'package:ziya_attendence_app/views/authentication/splash_screen.dart';
import 'providers/checkin_card_controller.dart';
import 'providers/dashboard_controllers/attendance_controller.dart';
import 'providers/dashboard_controllers/dash_board_controller.dart';
import 'providers/dashboard_controllers/payslip_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskController()),
        ChangeNotifierProvider(create: (context) => AttendanceProvider()),
        ChangeNotifierProvider(create: (context) => DashboardController()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => ResetPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => OtpViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (context) => LeaveRequestController()),
        ChangeNotifierProvider(create: (context) => LeaveDashboardController()),
        ChangeNotifierProvider(create: (context) => AttendanceController()),
        ChangeNotifierProvider(create: (context) => HolidayController()),
        ChangeNotifierProvider(create: (context) => LeaveStatusController()),
        ChangeNotifierProvider(create: (context) => PayslipController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => NotificationController()),
        ChangeNotifierProvider(create: (context) => SearchSheetController()),
        ChangeNotifierProvider(
          create: (context) => CheckFaceVerificationController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
