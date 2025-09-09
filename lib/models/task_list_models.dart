class Task {
  final String title;
  final String description;

  Task({required this.title, required this.description});
}

class TaskTracker {
  final String title;
  final String dueDate;
  final double progress;
  final String status;
  final String priority;
  final String updates;

  TaskTracker({
    required this.title,
    required this.dueDate,
    required this.progress,
    required this.status,
    required this.priority,
    required this.updates,
  });
}

class OngoingPendingTask {
  final String title;
  final double progress;
  final String status;
  final String startDate;
  final String dueDate;
  final String priority;
  final String buttonText;

  OngoingPendingTask({
    required this.title,
    required this.progress,
    required this.status,
    required this.startDate,
    required this.dueDate,
    required this.priority,
    required this.buttonText,
  });
}
