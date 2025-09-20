import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/text_constants.dart';
import '../providers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileController>(context).profile;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top banner + avatar + name+designation
              Container(
                height: 190.h,
                color: AppColors.whiteColor,
                child: Stack(
                  children: [
                    // Banner + gradient
                    Stack(
                      children: [
                        Image.asset(
                          TextConstants.profileBackgroundImage,
                          width: double.infinity,
                          height: 160.h,
                          fit: BoxFit.fitWidth,
                        ),
                        Container(
                          height: 160.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gradientBlue.withOpacity(0.2),
                                AppColors.gradientGreen.withOpacity(0.4),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Avatar
                    Positioned(
                      top: 95.h,
                      left: 30.w,
                      child: CircleAvatar(
                        radius: 48.r,
                        backgroundColor: AppColors.whiteColor,
                        child: CircleAvatar(
                          radius: 45.r,
                          backgroundImage: AssetImage(
                            TextConstants.profileImageUrl,
                          ),
                        ),
                      ),
                    ),
                    // Name & designation
                    Positioned(
                      top: 100.h,
                      left: 145.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name ?? TextConstants.name,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            profile.designation ?? TextConstants.designation,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyBorder),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    profileRow(TextConstants.name, profile.name),
                    Divider(color: AppColors.greyBorder),
                    profileRow(TextConstants.employeeId, profile.employeeId),
                    Divider(color: AppColors.greyBorder),
                    profileRow(TextConstants.designation, profile.designation),
                    Divider(color: AppColors.greyBorder),
                    profileRow(TextConstants.department, profile.department),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // (Optional) Illustration if needed
              // Image.asset(
              //   "lib/assets/multitask_illustration.jpg",
              //   height: 200.h,
              //   fit: BoxFit.contain,
              // ),
              SizedBox(height: 20.h),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  TextConstants.startWork,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  /// If imageUrl is null or empty, fallback to asset image
  ImageProvider<Object> _getProfileImageProvider(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return AssetImage(imageUrl);
    } else {
      return AssetImage(TextConstants.profileImageUrl);
    }
  }

  Widget profileRow(String title, String? value) {
    final display = (value != null && value.isNotEmpty) ? value : "-";
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title :',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              display,
              style: TextStyle(color: AppColors.textGrey, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
