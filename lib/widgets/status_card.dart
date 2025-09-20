import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';


class StatusCard extends StatelessWidget {
  final String title;
  final String value;
  final String subValue;
  final String subValue2;
  final String subtitle;
  final IconData icon;
  final Widget widget;

  const StatusCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
     required this.widget,
     required this.subValue,
    required this.subValue2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 12)),
                Icon(icon, color: AppColors.leavesOverviewIconClr),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
               const SizedBox(width: 10,),
                 Text(subValue, style: const TextStyle(fontSize: 10,)),

              ],
            ),
            Text(subValue2, style: const TextStyle(fontSize: 10,)),
            const SizedBox(height: 14),
            Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
            const SizedBox(height: 4),
            widget
          ],
        ),
      ),
    );
  }
}
