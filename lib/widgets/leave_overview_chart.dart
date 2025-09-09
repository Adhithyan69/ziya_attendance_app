
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';


class LeaveOverviewChart extends StatelessWidget {
  final List<int> quarterly;
  final int totalUsed;
  final int remaining;

  const LeaveOverviewChart({
    super.key,
    required this.quarterly,
    required this.totalUsed,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    final max = (quarterly.isEmpty ? 1 : quarterly.reduce((a, b) => a > b ? a : b)).toDouble();

    return Card(
      elevation: 2,
      color: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(TextConstants.leaveOverview,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text(TextConstants.leaveDistribution, style: TextStyle(fontSize: 12)),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: BarChart(
                BarChartData(
                  maxY: max,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text(
                          'Q${value.toInt() + 1}',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ),
                  barGroups: List.generate(quarterly.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: quarterly[i].toDouble(),
                          width: 40,
                          borderRadius: BorderRadius.zero,
                          color: AppColors.leavesOverviewContClr,
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: AppColors.leavesOverviewContClr, size: 12),
                const SizedBox(width: 8),
                const Text(TextConstants.leaveDaysTaken,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(TextConstants.totalDays, style: TextStyle(fontSize: 11)),
                    Text('$totalUsed', style: const TextStyle(fontSize: 11)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(TextConstants.remaining, style: TextStyle(fontSize: 11)),
                    Text('$remaining', style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
