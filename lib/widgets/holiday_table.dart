import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/holiday_controller.dart';


class HolidayTable extends StatelessWidget {
  const HolidayTable({super.key});

  @override
  Widget build(BuildContext context) {
    final holidays = Provider.of<HolidayController>(context).tableRecords;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: AppColors.greyBorder, blurRadius: 4),
        ],
      ),
      child: Table(
        border: TableBorder.all(color: AppColors.greyBorder),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2.5),
          2: FlexColumnWidth(2.5),
          3: FlexColumnWidth(2.5),
        },
        children: [
          _buildHeaderRow(TextConstants.dateHeader, holidays.map((e) => e.date).toList()),
          _buildHeaderRow(TextConstants.dayHeader, holidays.map((e) => e.day).toList()),
          _buildHeaderRow(TextConstants.holidayName, holidays.map((e) => e.holidayName).toList()),
          _buildHeaderRow(TextConstants.type, holidays.map((e) => e.type).toList()),
          _buildHeaderRow(TextConstants.note, holidays.map((e) => e.note).toList()),
        ],
      ),
    );
  }

  TableRow _buildHeaderRow(String title, List<String> values) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlue),
          ),
        ),
        ...values.map((val) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(val, textAlign: TextAlign.center),
        )),
      ],
    );
  }
}
