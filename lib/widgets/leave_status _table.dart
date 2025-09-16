import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/leave_status_controller.dart';
import '../constants/text_constants.dart';

class LeaveStatusTable extends StatelessWidget {
  const LeaveStatusTable({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case TextConstants.approved:
        return AppColors.approved;
      case TextConstants.pending:
        return AppColors.pending;
      case TextConstants.rejected:
        return AppColors.rejected;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveStatusController>(context).leaveTable;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.greyBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(color: Colors.grey.shade300),
        ),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(3),
          2: FlexColumnWidth(2),
          3: FlexColumnWidth(3),
        },
        children: [
          // Table Header
          TableRow(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            children: const [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Leave Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Reason',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          ...leaveData.map((item) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.date),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.leaveType),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.status,
                    style: TextStyle(
                      color: _getStatusColor(item.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item.reason),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
