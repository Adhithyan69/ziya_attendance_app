import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_controllers/reports_controller.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';

class AttendanceLineChart extends StatelessWidget {
  const AttendanceLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ReportsController>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(TextConstants.attendance,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 20),
          Row(
            children: [
              chartIndicator(color: AppColors.presenceClr, text: TextConstants.present),
              const SizedBox(width: 16),
              chartIndicator(color: AppColors.absenceClr, text: TextConstants.absent),
              const SizedBox(width: 16),
              chartIndicator(color: AppColors.avgHrsClr, text: TextConstants.avgHours),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 34,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, _) {
                        if (value.toInt() >= 0 && value.toInt() < TextConstants.months.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(TextConstants.months[value.toInt()],
                                style: const TextStyle(fontSize: 12)),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  _buildLine(controller.presentData, AppColors.presenceClr, true, offsetY: -10),
                  _buildLine(controller.absenceData, AppColors.absenceClr, true, offsetY: 2),
                  _buildLine(controller.avgHrsData, AppColors.avgHrsClr, true, offsetY: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _buildLine(List<double> data, Color color, bool showDots, {double offsetY = 0}) {
    return LineChartBarData(
      spots: data.asMap().entries
          .map((e) => FlSpot(e.key.toDouble(), e.value + offsetY))
          .toList(),
      color: color,
      barWidth: 2,
      shadow: Shadow(color: Colors.grey.shade300, offset: Offset(0, 10)),
      dotData: FlDotData(
        show: showDots,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 3,
            color: color,
            strokeWidth: 0,
          );
        },
      ),
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
    );
  }
}

Widget chartIndicator({required Color color, required String text}) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: color,
        ),
      ),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(fontSize: 12)),
    ],
  );
}