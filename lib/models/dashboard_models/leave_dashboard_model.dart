class LeaveData {
  final int totalTaken;
  final int remaining;
  final double approvalRate;
  final int pendingRequest;
  final int teamOnLeave;
  final List<int> quarterlyLeave;
  final int totalDaysUsed;

  final DateTime? upcomingStart;
  final DateTime? upcomingEnd;
  final String upcomingType;
  final String upcomingStatus;

  LeaveData({
    required this.totalTaken,
    required this.remaining,
    required this.approvalRate,
    required this.pendingRequest,
    required this.teamOnLeave,
    required this.quarterlyLeave,
    required this.totalDaysUsed,
    required this.upcomingStart,
    required this.upcomingEnd,
    required this.upcomingType,
    required this.upcomingStatus,
  });
}
