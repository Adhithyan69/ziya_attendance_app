import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/views/notification_screen.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  Route _createSlideRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder:
          (context, animation, secondaryAnimation) =>
              const NotificationScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 0.8.sw + 20.w, // ✅ screen width with ScreenUtil
          child: Stack(
            children: [
              Container(
                width: 0.8.sw,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade900, Colors.green],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(30.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  children: [
                    Container(
                      height: 50.h,
                      width: 45.w,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        image: DecorationImage(
                          image: AssetImage(TextConstants.profileImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextConstants.userName,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          TextConstants.userField,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 7.h,
                right: 5.w,
                child: CircleAvatar(
                  backgroundImage: AssetImage(TextConstants.ziyalogoImageUrl),
                  radius: 25.r,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(_createSlideRoute());
          },
          child: Container(
            padding: EdgeInsets.all(5.w),
            decoration: const BoxDecoration(
              color: AppColors.buttonColor,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(Icons.notifications, size: 25.sp, color: Colors.white),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// // import 'package:flutter/material.dart';
// // import 'package:ziya_attendence_app/constants/text_constants.dart';
// // import 'package:ziya_attendence_app/views/notification_screen.dart';

// // class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
// //   const HomeAppBarWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final double screenWidth = MediaQuery.of(context).size.width;

// //     return SafeArea(
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //         width: double.infinity,
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             /// Left Section - Profile with Gradient Background
// //             Expanded(
// //               child: Container(
// //                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [Colors.blue.shade900, Colors.green],
// //                     begin: Alignment.centerLeft,
// //                     end: Alignment.centerRight,
// //                   ),
// //                   borderRadius: const BorderRadius.horizontal(
// //                     right: Radius.circular(30),
// //                   ),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     /// Profile Image
// //                     Container(
// //                       height: 50,
// //                       width: 50,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(8),
// //                         image: const DecorationImage(
// //                           image: AssetImage(TextConstants.profileImageUrl), // replace
// //                           fit: BoxFit.cover,
// //                         ),
// //                       ),
// //                     ),

// //                     const SizedBox(width: 10),

// //                     /// Username & Field
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: const [
// //                           Text(
// //                             TextConstants.userName,
// //                             style: TextStyle(
// //                               fontSize: 14,
// //                               fontWeight: FontWeight.bold,
// //                               color: Colors.white,
// //                             ),
// //                             overflow: TextOverflow.ellipsis,
// //                           ),
// //                           Text(
// //                             TextConstants.userField,
// //                             style: TextStyle(
// //                               fontSize: 12,
// //                               color: Colors.white70,
// //                             ),
// //                             overflow: TextOverflow.ellipsis,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(width: 10),

// //             /// Logo Circle (Gradient Masking)
// //             Container(
// //               width: screenWidth * 0.12, // responsive size
// //               height: screenWidth * 0.12,
// //               decoration: const BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 gradient: LinearGradient(
// //                   colors: [Colors.blue, Colors.green],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 ),
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(3),
// //                 child: ClipOval(
// //                   child: Image.asset(
// //                      TextConstants.ziyalogoImageUrl, // replace with your logo
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //               ),
// //             ),

// //             const SizedBox(width: 10),

// //             /// Notification Button
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (_) => const NotificationScreen(), // replace with NotificationPage
// //                 ));
// //               },
// //               child: Container(
// //                 padding: const EdgeInsets.all(8),
// //                 decoration: const BoxDecoration(
// //                   color: Colors.orange,
// //                   shape: BoxShape.circle,
// //                 ),
// //                 child: Stack(
// //                   alignment: Alignment.topRight,
// //                   children: [
// //                     const Icon(Icons.notifications,
// //                         size: 26, color: Colors.white),
// //                     Positioned(
// //                       right: 0,
// //                       top: 0,
// //                       child: Container(
// //                         width: 9,
// //                         height: 9,
// //                         decoration: const BoxDecoration(
// //                           color: Colors.red,
// //                           shape: BoxShape.circle,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Size get preferredSize => const Size.fromHeight(70);
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class HomeAppBarWidget extends StatelessWidget {
//   const HomeAppBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // 🔹 Switch layout based on width
//         if (constraints.maxWidth < 600) {
//           return _mobileLayout();
//         } else {
//           return _tabletLayout();
//         }
//       },
//     );
//   }

//   // ---------------- Mobile Layout ----------------
//   Widget _mobileLayout() {
//     return Padding(
//       padding: EdgeInsets.all(16.w), // scaled padding ✅
//       child: Column(
//         children: [
//           _buildCard("Today’s Attendance", "95%", Colors.green),
//           SizedBox(height: 16.h), // scaled spacing ✅
//           _buildCard("Absent Students", "5", Colors.red),
//         ],
//       ),
//     );
//   }

//   // ---------------- Tablet Layout ----------------
//   Widget _tabletLayout() {
//     return Padding(
//       padding: EdgeInsets.all(24.w), // scaled padding ✅
//       child: GridView.count(
//         crossAxisCount: 2,
//         crossAxisSpacing: 20.w,
//         mainAxisSpacing: 20.h,
//         children: [
//           _buildCard("Today’s Attendance", "95%", Colors.green),
//           _buildCard("Absent Students", "5", Colors.red),
//           _buildCard("Pending Approvals", "3", Colors.orange),
//         ],
//       ),
//     );
//   }

//   // ---------------- Reusable Card ----------------
//   Widget _buildCard(String title, String value, Color color) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title,
//                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
//             SizedBox(height: 10.h),
//             Text(value,
//                 style: TextStyle(
//                     fontSize: 20.sp, fontWeight: FontWeight.bold, color: color)),
//           ],
//         ),
//       ),
//     );
//   }
// }
