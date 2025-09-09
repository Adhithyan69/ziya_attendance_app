import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import '../../../constants/color_constants.dart';
import '../../../models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (notification.type) {
      case TextConstants.missed:
        icon = Icons.close;
        color = AppColors.errorRed;
        break;
      case TextConstants.late:
        icon = Icons.alarm;
        color = AppColors.warningOrange;
        break;
      case TextConstants.summary:
        icon = Icons.wallet;
        color = AppColors.summaryBlue;
        break;
      case TextConstants.approval:
        icon = Icons.check_circle;
        color = AppColors.successGreen;
        break;
      case TextConstants.rejection:
        icon = Icons.remove_circle_outline;
        color = AppColors.errorRed;
        break;
      case TextConstants.shift:
        icon = Icons.repeat_on;
        color = AppColors.shiftBlue;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.grey;
    }

    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notification.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 15,
                      )),
                  const SizedBox(height: 4),
                  Text(notification.message,
                      style: const TextStyle(fontSize: 13, color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
