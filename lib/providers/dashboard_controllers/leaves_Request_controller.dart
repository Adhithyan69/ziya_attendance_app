import 'package:flutter/material.dart';
import '../../models/dashboard_models/leave_application_model.dart';

class LeaveRequestController extends ChangeNotifier {
  final List<LeaveApplication> _leaveApplications = [];

  List<LeaveApplication> get leaveApplications => _leaveApplications;

  void submitLeave(LeaveApplication application) {
    _leaveApplications.add(application);

    notifyListeners();
  }
}
