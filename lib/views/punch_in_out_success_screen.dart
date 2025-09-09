import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/color_constants.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';


class PunchInOutSuccessScreen extends StatefulWidget {
  final String time;
  final bool checkedIn;

  const PunchInOutSuccessScreen({super.key, required this.time, required this.checkedIn});

  @override
  State<PunchInOutSuccessScreen> createState() => _PunchInOutSuccessScreenState();
}

class _PunchInOutSuccessScreenState extends State<PunchInOutSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


@override
Widget build(BuildContext context) {
  final bool isCheckedIn = widget.checkedIn;

  final Color statusColor = isCheckedIn ? AppColors.successGreen : AppColors.successOrange;
  final String statusText = isCheckedIn ? TextConstants.punchInSuccessFull : TextConstants.punchOutSuccessFull;

  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white, statusColor.withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 200,),
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: statusColor,
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "$statusText\nat ${widget.time}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}}
