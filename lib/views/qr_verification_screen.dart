import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/views/punch_in_out_success_screen.dart';

class QrVerificationScreen extends StatefulWidget {
  const QrVerificationScreen({super.key, required this.time, required this.checkedIn});
  final String time;
  final bool checkedIn;
  @override
  State<QrVerificationScreen> createState() => _QrVerificationScreenState();
}

class _QrVerificationScreenState extends State<QrVerificationScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60,),
                const Text(
                  TextConstants.qrVerification,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.unSelectedTextColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  TextConstants.pleaseScanYourQRCode,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black54,
                  ),
                ),
                const SizedBox(height: 92),

                Center(
                  child: Container(
                    padding: EdgeInsets.all(32),
                    height: 220,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Lottie.asset(
                      TextConstants.qRAnimation,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 80),

                Center(
                  child: SizedBox(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PunchInOutSuccessScreen(time: widget.time, checkedIn: widget.checkedIn,)));
                      },
                      child: const Text(
                        TextConstants.scanQR,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
