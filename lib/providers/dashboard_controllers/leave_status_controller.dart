import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/models/dashboard_models/leave_status_model.dart';

class LeaveStatusController extends ChangeNotifier {
  final List<LeaveStatusModel> _records = [
    LeaveStatusModel(date: DateTime(2025, 6, 3), status: TextConstants.approved),
    LeaveStatusModel(date: DateTime(2025, 6, 12), status: TextConstants.approved),
    LeaveStatusModel(date: DateTime(2025, 6, 20), status: TextConstants.pending),
    LeaveStatusModel(date: DateTime(2025, 6, 16), status: TextConstants.rejected),
    LeaveStatusModel(date: DateTime(2025, 6, 17), status: TextConstants.rejected),
    LeaveStatusModel(date: DateTime(2025, 6, 25), status: TextConstants.company),
  ];

  List<LeaveStatusModel> get records => _records;

  Map<DateTime, Color> getDateColors() {
    final Map<DateTime, Color> colors = {};
    for (var r in _records) {
      final date = DateTime(r.date.year, r.date.month, r.date.day);
      switch (r.status) {
        case TextConstants.approved:
          colors[date] = AppColors.approved;
          break;
        case TextConstants.pending:
          colors[date] = AppColors.pending;
          break;
        case TextConstants.rejected:
          colors[date] = AppColors.rejected;
          break;
        case TextConstants.company:
          colors[date] = AppColors.companyClr;
          break;
      }
    }
    return colors;
  }

  final List<LeaveStatusTableModel> _leaveTable = [
    LeaveStatusTableModel(
        date: '10 June',
        leaveType: 'Sick Leave',
        status: 'Approved',
        reason: 'Fever'),
    LeaveStatusTableModel(
        date: '20 June',
        leaveType: 'Casual Leave',
        status: 'Pending',
        reason: 'Family Function'),
    LeaveStatusTableModel(
        date: '01 July',
        leaveType: 'WFH',
        status: 'Rejected',
        reason: 'No backup'),
  ];

  List<LeaveStatusTableModel> get leaveTable => _leaveTable;
}
