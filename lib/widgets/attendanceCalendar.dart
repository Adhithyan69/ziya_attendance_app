import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';

class AttendanceCalendar extends StatelessWidget {
  final Map<DateTime, Color> dateColors;
  final ValueNotifier<DateTime> focusedDayNotifier;

  const AttendanceCalendar({
    super.key,
    required this.dateColors,
    required this.focusedDayNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime>(
      valueListenable: focusedDayNotifier,
      builder: (context, focusedDay, _) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.calendarBorder, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      final newMonth = DateTime(
                        focusedDay.month == 1
                            ? focusedDay.year - 1
                            : focusedDay.year,
                        focusedDay.month == 1 ? 12 : focusedDay.month - 1,
                      );
                      focusedDayNotifier.value = newMonth;
                    },
                  ),
                  Text(
                    DateFormat(TextConstants.monthYearFormat).format(focusedDay),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      final newMonth = DateTime(
                        focusedDay.month == 12
                            ? focusedDay.year + 1
                            : focusedDay.year,
                        focusedDay.month == 12 ? 1 : focusedDay.month + 1,
                      );
                      focusedDayNotifier.value = newMonth;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.calendarBorder, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                headerVisible: false,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                onPageChanged: (newFocusedDay) {
                  focusedDayNotifier.value = newFocusedDay;
                },
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: AppColors.calendarWeekday,
                    fontWeight: FontWeight.bold,
                  ),
                  weekendStyle: TextStyle(
                    color: AppColors.calendarWeekday,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                  isTodayHighlighted: false,
                  cellMargin: EdgeInsets.all(4),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, _) {
                    final color = dateColors[DateTime(day.year, day.month, day.day)];

                    return Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
