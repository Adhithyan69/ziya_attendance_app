import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';


class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  Widget _buildCard(String label, String count, Color color,Color labelColor) {
    return Expanded(
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(label, style: TextStyle(color: labelColor)),
              const SizedBox(height: 4),
              Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCard(TextConstants.presence, TextConstants.presenceLength, AppColors.presenceClr,AppColors.presenceClr),
        _buildCard(TextConstants.absence, TextConstants.absenceLength, AppColors.absenceClr,AppColors.absenceClr),
        _buildCard(TextConstants.leaves,TextConstants.leavesLength, AppColors.leavesClr,AppColors.leavesClr),
      ],
    );
  }
}
