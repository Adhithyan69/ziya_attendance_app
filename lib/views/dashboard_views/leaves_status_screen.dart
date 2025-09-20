import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/leave_dashboard_controller.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/leave_status_controller.dart';
import 'package:ziya_attendence_app/widgets/infoCalendar.dart';
import 'package:ziya_attendence_app/widgets/leave_overview_chart.dart';
import 'package:ziya_attendence_app/widgets/leaves_screen_appBar.dart';
import 'package:ziya_attendence_app/widgets/status_card.dart';
import '../../widgets/leave_status _table.dart';

class LeavesStatusScreen extends StatelessWidget {
  const LeavesStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LeaveStatusController>(context, listen: false);
    final chartController = Provider.of<LeaveDashboardController>(context);
    final dateColor = controller.getDateColors();
    final data = chartController.leaveData;

    if (data == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: LeavesScreenAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.leaveTaken,
                      value: TextConstants.valueLeaveTaken,
                      subtitle: TextConstants.subtitleLeaveTaken,
                      icon: Icons.list_alt,
                      widget: Stack(
                        children: [
                          Container(
                            height: 5,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColors.progressTrackColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            height: 5,
                            width: 90,
                            decoration: BoxDecoration(
                              color: AppColors.progressColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                      subValue: '',
                      subValue2: '',
                    ),
                  ),
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.leaveBalance,
                      value: TextConstants.valueLeaveBalance,
                      subtitle:  TextConstants.leaveStatusDaysRemaining,
                      icon: Icons.calendar_month,
                      widget: const SizedBox.shrink(),
                      subValue: '',
                      subValue2: '',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.pendingRequest,
                      value: TextConstants.valuePendingRequest,
                      subtitle:  TextConstants.leaveStatusDaysRemaining,
                      icon: Icons.hourglass_empty_sharp,
                      widget: const SizedBox.shrink(),
                      subValue: '',
                      subValue2: '',
                    ),
                  ),
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.approvedLeaves,
                      value: TextConstants.valueApproved,
                      subtitle: TextConstants.leaveStatusDaysRemaining,
                      icon: Icons.check_circle_outline,
                      widget: const SizedBox.shrink(),
                      subValue: '',
                      subValue2: '',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.rejectedLeaves,
                      value: TextConstants.valueRejected,
                      subtitle:  TextConstants.leaveStatusDaysRemaining,
                      icon: Icons.cancel_outlined,
                      widget: const SizedBox.shrink(),
                      subValue: '',
                      subValue2: '',
                    ),
                  ),
                  Expanded(
                    child: StatusCard(
                      title: TextConstants.upcomingLeaves,
                      value: TextConstants.valueUpcoming,
                      subtitle: TextConstants.leaveStatusDaysRemaining,
                      icon: Icons.calendar_month,
                      widget: const SizedBox.shrink(),
                      subValue: '',
                      subValue2: TextConstants.scheduled,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InfoCalendar(dateColors: dateColor),
              const LeaveStatusTable(),
              LeaveOverviewChart(
                quarterly: data.quarterlyLeave,
                totalUsed: data.totalDaysUsed,
                remaining: data.remaining,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
