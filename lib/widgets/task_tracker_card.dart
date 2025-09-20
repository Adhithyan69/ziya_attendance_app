import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'dottedDivider.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String dueDate;
  final double progress;
  final String status;
  final String priority;
  final String updates;

  const TaskCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.progress,
    required this.status,
    required this.priority,
    required this.updates,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.listHeadingsTextColor)),
              Text("${TextConstants.ongoingDueDate} $dueDate",
                  style: const TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(TextConstants.ongoingStatus, style: TextStyle(fontSize: 12)),
              SizedBox(width: 2,),
              _statusDot(TextConstants.notStarted),
              _statusDot(TextConstants.inProgress),
              _statusDot(TextConstants.completed),
              _statusDot(TextConstants.overdue),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(TextConstants.progress, style: TextStyle(fontSize: 12)),
              CircularPercentIndicator(
                radius: 22.0,
                lineWidth: 4.0,
                percent: progress,
                center: Text("${(progress * 100).toInt()}%",
                    style: const TextStyle(fontSize: 10)),
                progressColor: Colors.green,
              ),
              Row(
                children: const [
                  Icon(Icons.timer, size: 18, color: Colors.orange),
                  SizedBox(width: 4),
                  Text(TextConstants.daysRemaining,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange, fontSize: 10)),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.edit_note, size: 18),
                  SizedBox(width: 4),
                  Text(TextConstants.assignedBy,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10)),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(TextConstants.ongoingPriority,
                  style: TextStyle(fontSize: 12)),
              const SizedBox(width: 10),
              _priorityText(TextConstants.lowPriority),
              _priorityText(TextConstants.mediumPriority),
              _priorityText(TextConstants.highPriority),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionItem(TextConstants.actionStart),
              _actionItem(TextConstants.actionUpdate),
              _actionItem(TextConstants.actionComplete),
            ],
          ),
          const SizedBox(height: 15),
          dottedDivider(60),
        ],
      ),
    );
  }

  Widget _statusDot(String label) {
    bool selected = label == status;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: selected ? Colors.green : Colors.grey.shade400,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _priorityText(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: priority == label ? Colors.teal : Colors.black,
        ),
      ),
    );
  }

  Widget _actionItem(String label) {
    bool selected = updates == label;
    return Row(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.grey.shade300,
          child: Icon(
            Icons.circle,
            size: 12,
            color: selected ? Colors.green : Colors.black,
          ),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
