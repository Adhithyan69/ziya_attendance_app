import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/holiday_controller.dart';
import 'package:ziya_attendence_app/widgets/infoCalendar.dart';
import 'package:ziya_attendence_app/widgets/status_card.dart';
import '../../widgets/holiday_table.dart';
import '../../widgets/leaves_screen_appBar.dart';

class HolidayListScreen extends StatelessWidget {
  const HolidayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HolidayController>(context);
    final dateColors = controller.getDateColors();

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: LeavesScreenAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatusCard(
                      subValue2: '',
                      subValue: '',
                      title: TextConstants.totalHolidays,
                      value: "18 days",
                      subtitle: TextConstants.inAYear,
                      icon: Icons.calendar_month,
                      widget: Stack(
                        children: [
                          Container(
                            height: 5,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                              color: AppColors.progressTrackColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            height: 5,
                            width: 90,
                            decoration: BoxDecoration(
                              color: AppColors.progressColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: StatusCard(
                      subValue2: '',
                      subValue: TextConstants.bakridNote,
                      title: TextConstants.upcomingHolidays,
                      value: "4",
                      subtitle: TextConstants.remainingThisMonth,
                      icon: Icons.calendar_month,
                      widget: const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildColorCode(AppColors.publicClr, TextConstants.public),
                  const SizedBox(width: 10),
                  _buildColorCode(
                      AppColors.optionalClr, TextConstants.optional),
                  const SizedBox(width: 10),
                  _buildColorCode(AppColors.companyClr, TextConstants.company),
                ],
              ),
              const SizedBox(height: 30),
              InfoCalendar(dateColors: dateColors),
              const SizedBox(height: 20),
              HolidayTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorCode(Color color, String value) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(value, style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}