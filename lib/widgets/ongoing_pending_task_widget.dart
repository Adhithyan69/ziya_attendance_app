import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'dottedDivider.dart';

class OngoingPendingTaskCard extends StatelessWidget {
  final String title;
  final double progress;
  final String status;
  final String startDate;
  final String dueDate;
  final String priority;
  final String buttonText;

  const OngoingPendingTaskCard({
    super.key,
    required this.title,
    required this.progress,
    required this.status,
    required this.startDate,
    required this.dueDate,
    required this.priority,
    required this.buttonText,
  });

  Color getStatusColor() {
    if (status.toLowerCase().contains("ongoing")) return Colors.blue;
    if (status.toLowerCase().contains("pending")) return Colors.orange;
    if (status.toLowerCase().contains("completed")) return Colors.green;
    return Colors.grey;
  }

  Color getPriorityColor() {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.tealAccent.shade400;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.listHeadingsTextColor,
                  ),
                ),
                Text(
                  '${(progress * 100).round()}${TextConstants.donePercentage}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text(TextConstants.ongoingStatus),
                Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: getStatusColor(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      buttonText == "Make as Done: "
                          ? TextConstants.startDate
                          : TextConstants.assignedDate,
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(startDate, style: const TextStyle(fontSize: 10)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      buttonText == "Make as Done: "
                          ? TextConstants.expectedCompletion
                          : TextConstants.ongoingDueDate,
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(dueDate, style: const TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Text(TextConstants.ongoingPriority),
                Text(
                  priority,
                  style: TextStyle(
                    color: getPriorityColor(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(color: AppColors.selectedTextColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            dottedDivider(60),
          ],
        ),
      ),
    );
  }
}
