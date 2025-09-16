import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/checkin_card_controller.dart';
import 'package:ziya_attendence_app/views/punch_in_out_success_screen.dart';

class QrReminderScreen extends StatefulWidget {
  const QrReminderScreen({
    super.key,
    required this.time,
    required this.checkedIn,
  });

  final String time;
  final bool checkedIn;

  @override
  State<QrReminderScreen> createState() => _QrReminderScreenState();
}

class _QrReminderScreenState extends State<QrReminderScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
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
                  style: TextStyle(fontSize: 18, color: AppColors.black54),
                ),
                const SizedBox(height: 92),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    height: 220,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
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
                      onPressed: () async {
                        final provider = Provider.of<AttendanceProvider>(
                          context,
                          listen: false,
                        );

                        bool result =
                            widget.checkedIn
                                ? await provider.checkIn()
                                : await provider.checkOut();

                        if (result) {
                          // ✅ Direct instant navigation without SnackBar
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => PunchInOutSuccessScreen(
                                    checkedIn: widget.checkedIn,
                                    time:
                                        widget.checkedIn
                                            ? provider.checkInTime!
                                            : provider.checkOutTime!,
                                  ),
                            ),
                          );
                        } else {
                          // ❌ Only show SnackBar on failure
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("QR scan failed ❌")),
                          );
                        }
                      },
                      child: const Text(
                        TextConstants.scanQR,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
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
