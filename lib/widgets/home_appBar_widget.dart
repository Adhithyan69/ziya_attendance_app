import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/views/notification_screen.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return SizedBox(
      height: preferredSize.height,
      child: Row(
        children: [
          SizedBox(
            width: 0.7.sw + 8.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: preferredSize.height,
                  width: 0.7.sw + 5.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.green],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(20.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          image: DecorationImage(
                            image: AssetImage(TextConstants.profileImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              TextConstants.userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: isTablet ? 10.sp : 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              TextConstants.userField,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: isTablet ? 8.sp : 12.sp,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: (preferredSize.height / 2) - 18.h,
                  right: -15.w,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(TextConstants.ziyalogoImageUrl),
                    radius: 19.r,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 40.w),

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
                  Icon(Icons.notifications, size: 24.sp, color: Colors.white),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 8.w,
                      height: 8.w,
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
      ),
    );
  }

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
}
