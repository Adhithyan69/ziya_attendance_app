import 'package:flutter/material.dart';
import '../../constants/text_constants.dart';
import '../../models/notification_model.dart';

class NotificationController with ChangeNotifier {
  final List<NotificationModel> _notifications = [
    NotificationModel(
      title: TextConstants.missedPunch,
      message: TextConstants.missedPunchMessage,
      type: TextConstants.missed,
    ),
    NotificationModel(
      title: TextConstants.lateAttendance,
      message: TextConstants.lateAttendanceMessage,
      type: TextConstants.late,
    ),
    NotificationModel(
      title: TextConstants.dailySummary,
      message: TextConstants.dailySummaryMessage,
      type: TextConstants.summary,
    ),
    NotificationModel(
      title: TextConstants.leaveApproval,
      message: TextConstants.leaveApprovalMessage,
      type: TextConstants.approval,
    ),
    NotificationModel(
      title: TextConstants.leaveRejection,
      message: TextConstants.leaveRejectionMessage,
      type: TextConstants.rejection,
    ),
    NotificationModel(
      title: TextConstants.shiftUpdate,
      message: TextConstants.shiftUpdateMessage,
      type: TextConstants.shift,
    ),
  ];

  List<NotificationModel> get notifications => _notifications;
}
