class LeaveStatusModel {
  final DateTime date;
  final String status;

  LeaveStatusModel({required this.date, required this.status});
}
class LeaveStatusTableModel {
  final String date;
  final String leaveType;
  final String status;
  final String reason;

  LeaveStatusTableModel({
    required this.date,
    required this.leaveType,
    required this.status,
    required this.reason,
  });
}
