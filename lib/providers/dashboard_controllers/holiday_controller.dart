import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/models/dashboard_models/holiday_model.dart';
import '../../constants/color_constants.dart';

class HolidayController extends ChangeNotifier {

  final List<HolidayModel> _calendarRecords = [
    HolidayModel(date: DateTime(2025, 6, 3), status: TextConstants.public),
    HolidayModel(date: DateTime(2025, 6, 12), status: TextConstants.public),
    HolidayModel(date: DateTime(2025, 6, 20), status: TextConstants.optional),
    HolidayModel(date: DateTime(2025, 6, 16), status: TextConstants.company),
    HolidayModel(date: DateTime(2025, 6, 17), status: TextConstants.company),
    HolidayModel(date: DateTime(2025, 6, 25), status: TextConstants.company),
  ];

  final List<HolidayTableModel> _tableRecords = [
    HolidayTableModel(
      date: TextConstants.date1,
      day: TextConstants.day1,
      holidayName: TextConstants.holiday1,
      type: TextConstants.type1,
      note: TextConstants.note1,
    ),
    HolidayTableModel(
      date: TextConstants.date2,
      day: TextConstants.day2,
      holidayName: TextConstants.holiday2,
      type: TextConstants.type2,
      note: TextConstants.note2,
    ),
    HolidayTableModel(
      date: TextConstants.date3,
      day: TextConstants.day3,
      holidayName: TextConstants.holiday3,
      type:TextConstants.type3,
      note: TextConstants.note2,
    ),
  ];

  List<HolidayModel> get calendarRecords => _calendarRecords;

  List<HolidayTableModel> get tableRecords => _tableRecords;

  Map<DateTime, Color> getDateColors() {
    final Map<DateTime, Color> colors = {};
    for (var r in _calendarRecords) {
      final date = DateTime(r.date.year, r.date.month, r.date.day);
      switch (r.status) {
        case TextConstants.public:
          colors[date] = AppColors.publicClr;
          break;
        case TextConstants.optional:
          colors[date] = AppColors.optionalClr;
          break;
        case TextConstants.company:
          colors[date] = AppColors.companyClr;
          break;
      }
    }
    return colors;
  }
}
