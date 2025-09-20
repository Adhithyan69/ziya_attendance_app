import 'package:flutter/material.dart';

import '../models/task_list_models.dart';

class TaskController extends ChangeNotifier {
  List<Task> get myTasks => [
        Task(
            title: 'UI/UX Design Implementation',
            description:
                'Translating design specifications into functional and visually appealing user interfaces using technologies like HTML, CSS, and JavaScript.'),
        Task(
            title: 'Responsive Design',
            description:
                'Ensuring that the application adapts seamlessly to different screen sizes and devices.'),
        Task(
            title: 'Back-end Development',
            description:
                'Creating and managing databases for efficient data storage, retrieval, and processing.'),
        Task(
            title: 'Server-Side Logic',
            description:
                'Developing and maintaining the logic that runs on the server, handling user requests, processing data, and interacting with databases.')
      ];

  List<TaskTracker> get trackers => [
        TaskTracker(
          title: 'Responsive Design',
          dueDate: '18-06-2025',
          progress: 0.45,
          status: 'In Progress',
          priority: 'Medium',
          updates: 'Complete',
        ),
        TaskTracker(
          title: 'UI/UX Design Implementation',
          dueDate: '18-06-2025',
          progress: 0.69,
          status: 'Completed',
          priority: 'High',
          updates: 'Update',
        ),
        TaskTracker(
          title: 'Back-end Development',
          dueDate: '18-06-2025',
          progress: 0.75,
          status: 'In Progress',
          priority: 'High',
          updates: 'Start',
        ),
      ];

  List<OngoingPendingTask> get ongoing => [
        OngoingPendingTask(
          title: "UI/UX Design Implementation",
          progress: 0.8,
          status: "Ongoing Task",
          startDate: "12-05-2025",
          dueDate: "12-06-2025",
          priority: "High",
          buttonText: "Make as Done",
        ),
        OngoingPendingTask(
          title: "Responsive Design",
          progress: 0.45,
          status: "Pending Task",
          startDate: "12-05-2025",
          dueDate: "12-06-2025",
          priority: "Medium",
          buttonText: "Start task",
        ),
        OngoingPendingTask(
          title: "Back-end Development",
          progress: 0.75,
          status: "Ongoing Task",
          startDate: "12-05-2025",
          dueDate: "12-06-2025",
          priority: "High",
          buttonText: "Make as Done",
        ),
        OngoingPendingTask(
          title: "Server-side Logic",
          progress: 0.75,
          status: "Pending Task",
          startDate: "12-05-2025",
          dueDate: "12-06-2025",
          priority: "Low",
          buttonText: "Start task",
        ),
      ];
}
