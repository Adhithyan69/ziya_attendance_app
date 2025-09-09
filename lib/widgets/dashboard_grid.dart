
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_controllers/dash_board_controller.dart';

class DashboardGridView extends StatelessWidget {
  const DashboardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DashboardController>(context);
    final items = controller.items;

    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => controller.onItemTap(context, item.label),
          child: Material(
            color: Colors.white,
            elevation: 2,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  CircleAvatar(
                    backgroundColor: item.color.withOpacity(0.2),
                    radius: 28,
                    child: Icon(item.icon, color: item.color),
                  ),
                  const SizedBox(height: 8),
                  Text(item.label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
