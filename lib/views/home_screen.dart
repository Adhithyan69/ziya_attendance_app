// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:ziya_attendence_app/constants/text_constants.dart';
// import 'package:ziya_attendence_app/widgets/home_appBar_widget.dart';
// import '../providers/checkin_card_controller.dart';
// import '../widgets/check-in-out_section/checkin_card.dart';
// import '../widgets/overview_section.dart';
// import '../widgets/dashboard_grid.dart';
// import '../widgets/tapbar.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final punchIn = Provider.of<AttendanceProvider>(context).isCheckedIn;
//     return DefaultTabController(
//       length: 4,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(60),
//             child: HomeAppBarWidget(),
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 10),
//                   const Text(
//                     '${TextConstants.wishes} ${TextConstants.userName}"',
//                     style: TextStyle(color: Colors.grey, fontSize: 18),
//                   ),
//                   const SizedBox(height: 20),
//                   const CheckInCard(),
//                   const SizedBox(height: 10),
//                   const Text(
//                     TextConstants.overView,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const OverviewSection(),
//                   const SizedBox(height: 10),
//                   punchIn ? TabBarSection() : SizedBox.shrink(),
//                   const SizedBox(height: 10),
//                   const Text(
//                     TextConstants.dashboard,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const DashboardGridView(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/widgets/home_appBar_widget.dart';
import '../providers/checkin_card_controller.dart';
import '../widgets/check-in-out_section/checkin_card.dart';
import '../widgets/overview_section.dart';
import '../widgets/dashboard_grid.dart';
import '../widgets/tapbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final punchIn = Provider.of<AttendanceProvider>(context).isCheckedIn;

    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar:
              const HomeAppBarWidget(), // already implements PreferredSizeWidget
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w), // ✅ responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h), // ✅ responsive spacing
                  Text(
                    '${TextConstants.wishes} ${TextConstants.userName}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.sp, // ✅ responsive font
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const CheckInCard(),
                  SizedBox(height: 10.h),
                  Text(
                    TextConstants.overView,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp, // ✅ responsive font
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const OverviewSection(),
                  SizedBox(height: 10.h),
                  punchIn ? const TabBarSection() : const SizedBox.shrink(),
                  SizedBox(height: 10.h),
                  Text(
                    TextConstants.dashboard,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp, // ✅ responsive font
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const DashboardGridView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
