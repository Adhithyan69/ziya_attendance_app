import 'package:flutter/material.dart';
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
              Container(
                height: 190,
                color: AppColors.whiteColor,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "lib/assets/bg_banner.jpg",
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.fitWidth,
                        ),
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gradientBlue.withOpacity(0.2),
                                AppColors.gradientGreen.withOpacity(0.4),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 95,
                      left: 30,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: AppColors.whiteColor,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage:
                          AssetImage(TextConstants.profileImageUrl),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: 145,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          Text(
                            profile.designation,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyBorder),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    profileRow(TextConstants.name, profile.name),
                    const Divider(color: AppColors.greyBorder),
                    profileRow(TextConstants.employeeId, profile.employeeId),
                    const Divider(color: AppColors.greyBorder),
                    profileRow(TextConstants.designation, profile.designation),
                    const Divider(color: AppColors.greyBorder),
                    profileRow(TextConstants.department, profile.department),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Image.asset("lib/assets/multitask_illustration.jpg", height: 200),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  TextConstants.startWork,
                  style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$title :',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(color: AppColors.textGrey),
            ),
          ),
        ],
      ),
    );
  }
}
