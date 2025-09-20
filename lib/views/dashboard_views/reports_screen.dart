import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/reports_controller.dart';
import 'package:ziya_attendence_app/widgets/leaves_screen_appBar.dart';
import 'package:ziya_attendence_app/widgets/status_card.dart';
import '../../widgets/attendanceLine_chart.dart';
import '../../widgets/clockLog_table.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportsController(),
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: LeavesScreenAppBar(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 15),
                      SizedBox(width: 5),
                      Text(
                        TextConstants.reportsTitle,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.totalWorkingDays,
                      value: TextConstants.workingDaysValue,
                      subtitle: '',
                      icon: Icons.calendar_month,
                      widget: const SizedBox.shrink(),
                      subValue: '',
                      subValue2: TextConstants.thisMonth,
                    ),
                  ),
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.totalHoursWorked,
                      value: TextConstants.totalHoursValue,
                      subtitle: '',
                      icon: Icons.hourglass_empty_sharp,
                      widget: const SizedBox.shrink(),
                      subValue: '',
                      subValue2: '',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.tasksCompleted,
                      value: TextConstants.completedValue,
                      subtitle: '',
                      icon: Icons.check_circle_outline,
                      widget: const SizedBox.shrink(),
                      subValue: TextConstants.thisMonthSmall,
                      subValue2: '',
                    ),
                  ),
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.avgDailyHours,
                      value: TextConstants.avgHoursValue,
                      subtitle: '',
                      icon: Icons.alarm,
                      widget: const SizedBox.shrink(),
                      subValue: TextConstants.hoursPerDay,
                      subValue2: '',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const ClockLogTable(),
              const AttendanceLineChart(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
