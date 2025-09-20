import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_controller.dart';
import '../widgets/simple_task_card.dart';
import '../widgets/task_tracker_card.dart';
import '../widgets/ongoing_pending_task_widget.dart';
import '../widgets/work_summary_grid.dart';
import '../constants/color_constants.dart';
import '../constants/text_constants.dart';

class TabBarSection extends StatefulWidget {
  const TabBarSection({super.key});

  @override
  State<TabBarSection> createState() => _TabBarSectionState();
}

class _TabBarSectionState extends State<TabBarSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> tabs = [
    {'icon': Icons.calendar_today, 'label': TextConstants.tabMyTasks},
    {'icon': Icons.hourglass_bottom, 'label': TextConstants.tabTaskTracker},
    {'icon': Icons.loop, 'label': TextConstants.tabOngoing},
    {'icon': Icons.wallet, 'label': TextConstants.tabWorkSummary},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskController = Provider.of<TaskController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              final selected = _tabController.index == index;
              return GestureDetector(
                onTap: () {
                  _tabController.animateTo(index);
                },
                child: Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.buttonColor : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        tabs[index]['icon'],
                        color: selected
                            ? AppColors.selectedTextColor
                            : AppColors.unSelectedTextColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tabs[index]['label'],
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Text(TextConstants.sortBy,
                style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Radio(value: true, groupValue: true, onChanged: null),
            Text(TextConstants.deadline),
            SizedBox(width: 20),
            Radio(value: true, groupValue: true, onChanged: null),
            Text(TextConstants.project),
            Spacer(),
            Icon(Icons.tune),
          ],
        ),
        const SizedBox(height: 10),
        AutoScaleTabBarView(
          controller: _tabController,
          children: [
            Column(
              children: taskController.myTasks
                  .map((task) => SimpleTaskCard(
                title: task.title,
                description: task.description,
              ))
                  .toList(),
            ),
            Column(
              children: taskController.trackers
                  .map((task) => TaskCard(
                title: task.title,
                dueDate: task.dueDate,
                progress: task.progress,
                status: task.status,
                priority: task.priority,
                updates: task.updates,
              ))
                  .toList(),
            ),
            Column(
              children: taskController.ongoing
                  .map((task) => OngoingPendingTaskCard(
                title: task.title,
                progress: task.progress,
                status: task.status,
                startDate: task.startDate,
                dueDate: task.dueDate,
                priority: task.priority,
                buttonText: task.buttonText,
              ))
                  .toList(),
            ),
            const ProductivityDashboard(),
          ],
        ),
      ],
    );
  }
}
