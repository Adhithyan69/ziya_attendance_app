import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/views/punch_in_out_success_screen.dart';


class CheckVerificationScreen extends StatefulWidget {
  const CheckVerificationScreen({super.key, required this.time, required this.checkedIn});
  final String time;
  final bool checkedIn;
  @override
  State<CheckVerificationScreen> createState() => _CheckVerificationScreenState();
}

class _CheckVerificationScreenState extends State<CheckVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            TextConstants.centerYourFace,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            TextConstants.checkVerifcnText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xFFB0E0FF), Color(0xFF1DAEFF)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 19,
                        child: IconButton(
                          icon: const Icon(Icons.flip_camera_ios, size: 20),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 30),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          icon: const Icon(Icons.check,
                              color: Colors.white, size: 52),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PunchInOutSuccessScreen(time: widget.time,checkedIn: widget.checkedIn,)));
                          },
                        ),
                      ),
                      const SizedBox(width: 30),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 19,
                        child: IconButton(
                          icon: const Icon(Icons.flash_on, size: 20),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
