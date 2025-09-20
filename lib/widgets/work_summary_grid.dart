import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/models/prodectivity_dashB_item.dart';

class ProductivityDashboard extends StatelessWidget {
  const ProductivityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProdectivityDashbItem> summaryItem = [
      ProdectivityDashbItem(
        title: TextConstants.totalWorkingDays,
        icon: Icons.calendar_month,
        subtitle: TextConstants.totalWorkingDaysValue,
      ),
      ProdectivityDashbItem(
        title: TextConstants.totalHoursWorked,
        icon: Icons.access_time,
        subtitle: TextConstants.totalHoursWorkedValue,
      ),
      ProdectivityDashbItem(
        title: TextConstants.averageDailyHours,
        icon: Icons.av_timer,
        subtitle: TextConstants.averageDailyHoursValue,
      ),
      ProdectivityDashbItem(
        title: TextConstants.productivityIndicator,
        icon: Icons.bar_chart,
        subtitle: TextConstants.productivityIndicatorValue,
      ),
      ProdectivityDashbItem(
        title: TextConstants.projectsInvolved,
        icon: Icons.person,
        subtitle: TextConstants.projectsInvolvedValue,
      ),
      ProdectivityDashbItem(
        title: TextConstants.leaveTaken,
        icon: Icons.library_books_outlined,
        subtitle: TextConstants.leaveTakenValue,
      ),
    ];

    return Card(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: summaryItem.map((item) {
            return Material(
              elevation: 2,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item.icon,
                          color: AppColors.dashboardGridItemColor, size: 30),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title,
                                style: const TextStyle(
                                  fontSize: 9.2,
                                  color: AppColors.dashboardGridTextColor,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            const SizedBox(height: 6),
                            Text(item.subtitle,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.dashboardGridTextColor,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
