import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceProvider extends ChangeNotifier {
  bool _isCheckedIn = false;
  bool _isOnsite = false;

  String? _checkInTime;
  String? _checkOutTime;

  // Getters
  bool get isCheckedIn => _isCheckedIn;
  bool get isOnsite => _isOnsite;
  String? get checkInTime => _checkInTime;
  String? get checkOutTime => _checkOutTime;

  /// ✅ Mark only check-in (does not care if onsite or WFH)
  void checkIn() {
    _isCheckedIn = true;
    _checkInTime = DateFormat('hh:mm a').format(DateTime.now());
    _checkOutTime = null; // reset old checkout
    notifyListeners();
  }

  /// ✅ Mark only check-out
  void checkOut() {
    _isCheckedIn = false;
    _checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
    notifyListeners();
  }

  /// ✅ Separate method to set onsite/WFH
  void setWorkMode(bool onsite) {
    _isOnsite = onsite;
    notifyListeners();
  }
}
