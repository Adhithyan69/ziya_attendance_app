import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/checkin_card_model.dart';


class AttendanceProvider extends ChangeNotifier {
  final AttendanceModel _data = AttendanceModel();

  bool get isCheckedIn => _data.isCheckedIn;
  String? get checkInTime => _data.checkInTime;
  String? get checkOutTime => _data.checkOutTime;
  bool get isOnsite=>_data.isOnsite;

  void checkIn({required bool onsite}) {
    _data.isCheckedIn = true;
    _data.checkInTime = DateFormat('hh:mm a').format(DateTime.now());
    _data.isOnsite=onsite;
    notifyListeners();
  }

  void checkOut() {
    _data.isCheckedIn = false;
    _data.checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
    notifyListeners();
  }
}
