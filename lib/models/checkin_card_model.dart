class AttendanceModel {
  bool isCheckedIn;
  bool isOnsite;
  String? checkInTime;
  String? checkOutTime;

  AttendanceModel({
    this.isCheckedIn = false,
    this.isOnsite = false,
    this.checkInTime,
    this.checkOutTime,
  });
}
