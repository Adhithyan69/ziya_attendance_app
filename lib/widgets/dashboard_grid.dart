import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8.h),
                  CircleAvatar(
                    backgroundColor: item.color.withOpacity(0.2),
                    radius: 28.r,
                    child: Icon(item.icon, color: item.color, size: 24.r),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
