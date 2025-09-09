class HolidayModel {
  final DateTime date;
  final String status;

  HolidayModel({required this.date, required this.status});
}
class HolidayTableModel {
  final String date;
  final String day;
  final String holidayName;
  final String type;
  final String note;

  HolidayTableModel({
    required this.date,
    required this.day,
    required this.holidayName,
    required this.type,
    required this.note,
  });
}
