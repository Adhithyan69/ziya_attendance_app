import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_controllers/reports_controller.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';

class ClockLogTable extends StatelessWidget {
  const ClockLogTable({super.key});

  Color getStatusColor(String status) {
    switch (status) {
      case TextConstants.present:
        return AppColors.presenceClr;
      case TextConstants.absent:
        return AppColors.absenceClr;
      case TextConstants.halfDay:
        return AppColors.halfDayClr;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ReportsController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          TextConstants.dailyClockLog,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyBorder),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(5),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.8),
              1: FlexColumnWidth(1.6),
              2: FlexColumnWidth(1.6),
              3: FlexColumnWidth(1.3),
              4: FlexColumnWidth(1.5),
            },
            border: TableBorder.symmetric(
              inside: BorderSide(color: AppColors.greyBorder, width: 0.5),
            ),
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                children:  [
                  clockTableHeaderCell(TextConstants.date),
                  clockTableHeaderCell(TextConstants.checkIn),
                  clockTableHeaderCell(TextConstants.checkOut),
                  clockTableHeaderCell(TextConstants.totalHrs),
                  clockTableHeaderCell(TextConstants.status),
                ],
              ),
              ...controller.clockLogs.map((log) => TableRow(
                children: [
                  clockTableDataCell(log.date),
                  clockTableDataCell(log.checkIn),
                  clockTableDataCell(log.checkOut),
                  clockTableDataCell("${log.totalHrs} ${TextConstants.hrsSuffix}"),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      log.status,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: getStatusColor(log.status),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }
}

Widget clockTableHeaderCell(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    ),
  );
}


Widget clockTableDataCell(String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Text(
      value,
      style: const TextStyle(fontSize: 12),
    ),
  );
}

