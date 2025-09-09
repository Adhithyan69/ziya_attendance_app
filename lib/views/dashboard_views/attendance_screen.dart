import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/widgets/attendanceCalendar.dart';
import 'package:ziya_attendence_app/widgets/dottedDivider.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';
import '../../providers/dashboard_controllers/attendance_controller.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AttendanceController>(context);
    final dateColors = controller.getDateColors();
    final focusedDayNotifier = ValueNotifier<DateTime>(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: const Text(TextConstants.attendanceCalendar),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AttendanceCalendar(
              dateColors: dateColors,
              focusedDayNotifier: focusedDayNotifier,
            ),
            const SizedBox(height: 12),
            Card(
              color: AppColors.secondaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      TextConstants.overView,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    const Text(
                      TextConstants.totalDays,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Row(
                      children: [
                        _buildOverviewCard(TextConstants.presence,
                            TextConstants.presenceLength, AppColors.presenceClr),
                        _buildOverviewCard(TextConstants.absence,
                            TextConstants.absenceLength, AppColors.absenceClr),
                        _buildOverviewCard(TextConstants.leaves,
                            TextConstants.leavesLength, AppColors.leavesClr),
                        _buildOverviewCard(TextConstants.late,
                            TextConstants.lateLength, AppColors.lateClr),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _buildPieChart(controller.getSummary()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              TextConstants.june18,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(TextConstants.status,
                    style: TextStyle(fontSize: 15)),
                Chip(
                  label: const Text(TextConstants.present,
                      style: TextStyle(color: AppColors.presenceClr)),
                  color: WidgetStatePropertyAll(AppColors.presenceClr.withOpacity(0.3)),
                  side: BorderSide.none,
                ),
              ],
            ),
            dottedDivider(66),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildCheckInfo(Icons.alarm_on, TextConstants.checkIn,
                    TextConstants.checkInTime, AppColors.presenceClr),
                const Spacer(),
                Row(
                  children: const [
                    SizedBox(width: 50, child: Divider(thickness: 1.2)),
                    Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.grey),
                  ],
                ),
                const Spacer(),
                _buildCheckInfo(Icons.alarm_off, TextConstants.checkOut,
                    TextConstants.checkOutTime, AppColors.presenceClr),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildTagBox(
                    TextConstants.workMode,
                    TextConstants.office,
                    AppColors.tagOfficeBg,
                    AppColors.tagOfficeText),
                const Spacer(),
                _buildTagBox(
                    TextConstants.verification,
                    TextConstants.selfie,
                    AppColors.tagSelfieBg,
                    AppColors.tagSelfieText),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoBox(
              icon: Icons.person_pin_circle_outlined,
              label: TextConstants.location,
              value: TextConstants.locationValue,
              iconColor: Colors.red,
            ),
            const SizedBox(height: 8),
            _buildInfoBox(
              icon: Icons.text_snippet_outlined,
              label: TextConstants.notes,
              value: TextConstants.workedNote,
              iconColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String label, String count, Color color) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(label, style: TextStyle(color: color, fontSize: 11)),
              const SizedBox(height: 4),
              Text(count,
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckInfo(
      IconData icon, String label, String time, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(time, style: TextStyle(color: color)),
          ],
        )
      ],
    );
  }

  Widget _buildTagBox(
      String label, String value, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: AppColors.tagBorderClr, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              )),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: bgColor,
            ),
            child: Text(value,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Card(
      color: AppColors.secondaryColor,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<String, int> summary) {
    final colors = {
      TextConstants.presence: AppColors.presenceClr,
      TextConstants.absence: AppColors.absenceClr,
      TextConstants.leaves: AppColors.leavesClr,
      TextConstants.late: AppColors.lateClr,
    };

    return Container(
      height: 200,
      width: double.infinity,
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: summary.entries.map((entry) {
            final label = "${entry.value.toString().padLeft(2, '0')} \nDays";
            return PieChartSectionData(
              value: entry.value.toDouble(),
              color: colors[entry.key],
              title: label,
              titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white,
              ),
              radius: 60,
            );
          }).toList(),
        ),
      ),
    );
  }
}
