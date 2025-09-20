import 'package:flutter/material.dart';
import '../../models/dashboard_models/leave_dashboard_model.dart';

class LeaveDashboardController extends ChangeNotifier {
  LeaveData? _leaveData;

  LeaveData? get leaveData => _leaveData;

  bool _loading = true;
  bool get isLoading => _loading;

  LeaveDashboardController() {
    loadLeaveData();
  }

  void loadLeaveData() {
    _loading = true;
    notifyListeners();

    _leaveData = LeaveData(
      totalTaken: 16,
      remaining: 29,
      approvalRate: 92,
      pendingRequest: 1,
      teamOnLeave: 2,
      quarterlyLeave: [4, 3, 2, 1],
      totalDaysUsed: 20,
      upcomingStart: DateTime(2025, 4, 22),
      upcomingEnd: DateTime(2025, 4, 24),
      upcomingType: 'Annual Leave',
      upcomingStatus: 'Pending',
    );

    _loading = false;
    notifyListeners();
  }
}
