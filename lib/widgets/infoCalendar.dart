import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants/color_constants.dart';

class InfoCalendar extends StatelessWidget {
  final Map<DateTime, Color> dateColors;

  const InfoCalendar({
    super.key,
    required this.dateColors,
  });

  @override
  Widget build(BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.calendarBorder, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            headerVisible: true,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: AppColors.calendarWeekday,
                fontWeight: FontWeight.bold,
              ),
              weekendStyle: TextStyle(
                color: AppColors.calendarWeekend,
                fontWeight: FontWeight.bold,
              ),
            ),
            headerStyle: HeaderStyle(
              titleCentered: false,
                formatButtonVisible: false,
                leftChevronVisible: false,
                rightChevronVisible: false
            ),
            calendarStyle:  CalendarStyle(
              outsideDaysVisible: false,
              isTodayHighlighted: false,
              tableBorder: TableBorder.all(color: Colors.grey.shade200),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                final normalizedDay = DateTime(day.year, day.month, day.day);
                final color = dateColors[normalizedDay];
                final isWeekend = day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;

                return Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: color,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isWeekend ? Colors.red : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        );
  }
}
