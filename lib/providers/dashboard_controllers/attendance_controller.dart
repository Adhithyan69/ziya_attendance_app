import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import '../../models/dashboard_models/attendance_model.dart';

class AttendanceController extends ChangeNotifier {
  final List<Attendance> _records = [
    Attendance(date: DateTime(2025, 6, 6), status: 'Late'),
    Attendance(date: DateTime(2025, 6, 9), status: 'Presence'),
    Attendance(date: DateTime(2025, 6, 10), status: 'Presence'),
    Attendance(date: DateTime(2025, 6, 16), status: 'Presence'),
    Attendance(date: DateTime(2025, 6, 17), status: 'Presence'),
    Attendance(date: DateTime(2025, 6, 24), status: 'Absence'),
    Attendance(date: DateTime(2025, 6, 25), status: 'Leave'),
  ];

  List<Attendance> get records => _records;

  Map<DateTime, Color> getDateColors() {
    final Map<DateTime, Color> colors = {};
    for (var r in _records) {
      final date = DateTime(r.date.year, r.date.month, r.date.day);
      switch (r.status) {
        case 'Presence':
          colors[date] = AppColors.presenceClr;
          break;
        case 'Absence':
          colors[date] = AppColors.absenceClr;
          break;
        case 'Leave':
          colors[date] =AppColors.leavesClr;
          break;
        case 'Late':
          colors[date] = AppColors.lateClr;
          break;
      }
    }
    return colors;
  }

  Map<String, int> getSummary() {
    int present = 20, absent = 3, leave = 2, late = 6;
    return {
      'Presence': present,
      'Absence': absent,
      'Leave': leave,
      'Late': late,
    };
  }
}
