// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../constants/color_constants.dart';
// import '../../constants/text_constants.dart';
// import '../../providers/checkin_card_controller.dart';

// class PunchInOutSuccessScreen extends StatefulWidget {
//   const PunchInOutSuccessScreen({
//     super.key,
//     required this.checkedIn,
//     required this.time,
//   });

//   final bool checkedIn;
//   final String time;

//   @override
//   State<PunchInOutSuccessScreen> createState() =>
//       _PunchInOutSuccessScreenState();
// }

// class _PunchInOutSuccessScreenState extends State<PunchInOutSuccessScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//     _controller.forward();

//     // Automatically pop after 2 seconds
//     Timer(const Duration(seconds: 2), () {
//       if (mounted) Navigator.pop(context);
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<AttendanceProvider>(context);
//     final Color statusColor =
//         widget.checkedIn ? AppColors.successGreen : AppColors.successOrange;
//     final String statusText =
//         widget.checkedIn
//             ? TextConstants.punchInSuccessFull
//             : TextConstants.punchOutSuccessFull;

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Colors.white, statusColor.withOpacity(0.8)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: 200.h),
//             Center(
//               child: FadeTransition(
//                 opacity: _animation,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CircleAvatar(
//                       radius: 40.r,
//                       backgroundColor: statusColor,
//                       child: Icon(
//                         Icons.check,
//                         color: Colors.white,
//                         size: 50.sp,
//                       ),
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       "$statusText at\n${widget.time}",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: statusColor,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';

class PunchInOutSuccessScreen extends StatefulWidget {
  const PunchInOutSuccessScreen({
    super.key,
    required this.checkedIn,
    required this.time,
  });

  final bool checkedIn;
  final String time;

  @override
  State<PunchInOutSuccessScreen> createState() =>
      _PunchInOutSuccessScreenState();
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

    // ✅ After 2 seconds, return to previous (Dashboard or Home)
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
    final Color statusColor =
        widget.checkedIn ? AppColors.successGreen : AppColors.successOrange;
    final String statusText =
        widget.checkedIn
            ? TextConstants.punchInSuccessFull
            : TextConstants.punchOutSuccessFull;

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
            SizedBox(height: 200.h),
            Center(
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundColor: statusColor,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "$statusText at\n${widget.time}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 16.sp,
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
  }
}
