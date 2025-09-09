import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/views/dashboard_views/leaves_status_screen.dart';
import 'package:ziya_attendence_app/views/dashboard_views/pays_lip_screen.dart';
import '../../models/dashboard_models/dashboard_item.dart';
import '../../../constants/color_constants.dart';
import '../../views/dashboard_views/attendance_screen.dart';
import '../../views/dashboard_views/holiday_list_screen.dart';
import '../../views/dashboard_views/leaves_screen.dart';
import '../../views/dashboard_views/reports_screen.dart';

class DashboardController extends ChangeNotifier {
  final List<DashboardItem> _items = [
    DashboardItem(label: "Attendance", icon: Icons.calendar_month, color: AppColors.dashboardAttendanceColor),
    DashboardItem(label: "Leaves", icon: Icons.logout, color: AppColors.dashboardLeavesColor),
    DashboardItem(label: "Leave Status", icon: Icons.pie_chart, color: AppColors.dashboardLeavesStatusColor),
    DashboardItem(label: "Holiday List", icon: Icons.checklist_sharp, color: AppColors.dashboardHolidayColor),
    DashboardItem(label: "Payslip", icon: Icons.my_library_books, color: AppColors.dashboardPayslipColor),
    DashboardItem(label: "Reports", icon: Icons.show_chart, color: AppColors.dashboardReportsColor),
  ];

  List<DashboardItem> get items => _items;

  void onItemTap(BuildContext context, String label) {
    Widget page;
    switch (label) {
      case "Attendance":
        page = const AttendanceScreen();
        break;
      case "Leaves":
        page = const LeavesScreen();
        break;
      case "Leave Status":
        page = const LeavesStatusScreen();
        break;
      case "Holiday List":
        page = const HolidayListScreen();
        break;
      case "Payslip":
        page = const PayslipScreen();
        break;
      case "Reports":
        page = const ReportsScreen();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}
