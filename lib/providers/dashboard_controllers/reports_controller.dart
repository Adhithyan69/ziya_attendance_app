import 'package:flutter/material.dart';

import '../../models/dashboard_models/reports_models.dart';

class ReportsController with ChangeNotifier {
  final List<ClockLogModel> clockLogs = [
    ClockLogModel(
        date: 'June 21', checkIn: '09:15 AM', checkOut: '05:45 PM', totalHrs: '8.5 hrs', status: 'Present'),
    ClockLogModel(
        date: 'June 22', checkIn: '--', checkOut: '--', totalHrs: '0 hrs', status: 'Absent'),
    ClockLogModel(
        date: 'June 23', checkIn: '09:30 AM', checkOut: '04:00 PM', totalHrs: '6.5 hrs', status: 'Half Day'),
  ];

  List<double> presentData = [20, 22, 18, 24, 19, 23, 25, 22, 21, 23, 24, 26];
  List<double> absenceData = [4, 0, 3, 0, 2, 5, 0, 1, 2, 3, 1, 0];
  List<double> avgHrsData = [4, 6.5, 4, 6.8, 2, 6.7, 7.0, 6.5, 6.4, 6.6, 6.8, 7.0];
}
