// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:provider/provider.dart';
// import 'package:ziya_attendence_app/providers/checkin_card_controller.dart';
// import 'package:ziya_attendence_app/viewModels/auth_view_models/login_viewmodel.dart';
// import 'punch_in_out_success_screen.dart';

// class QrVerificationScreen extends StatefulWidget {
//   final bool isCheckIn;

//   const QrVerificationScreen({super.key, required this.isCheckIn});

//   @override
//   State<QrVerificationScreen> createState() => _QrVerificationScreenState();
// }

// class _QrVerificationScreenState extends State<QrVerificationScreen> {
//   bool _scanned = false;
//   late final MobileScannerController _scannerController;

//   @override
//   void initState() {
//     super.initState();
//     _scannerController = MobileScannerController(
//       facing: CameraFacing.back,
//       torchEnabled: false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loginVm = Provider.of<LoginViewModel>(context, listen: false);
//     final userId = loginVm.userId;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.isCheckIn ? "QR Check-In" : "QR Check-Out"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.flash_on),
//             onPressed: () => _scannerController.toggleTorch(),
//           ),
//           IconButton(
//             icon: const Icon(Icons.cameraswitch),
//             onPressed: () => _scannerController.switchCamera(),
//           ),
//         ],
//       ),
//       body: MobileScanner(
//         controller: _scannerController,
//         onDetect: (BarcodeCapture capture) async {
//           if (_scanned) return; // prevent multiple triggers
//           final code = capture.barcodes.first.rawValue;
//           if (code == null || code.isEmpty || userId == null) return;

//           _scanned = true;
//           final provider = Provider.of<AttendanceProvider>(
//             context,
//             listen: false,
//           );

//           try {
//             final result =
//                 widget.isCheckIn
//                     ? await provider.checkInWithQr(code)
//                     : await provider.checkOutWithQr(code);

//             if (!mounted) return;

//             if (result.success) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (_) => PunchInOutSuccessScreen(
//                         checkedIn: widget.isCheckIn,
//                         time:
//                             widget.isCheckIn
//                                 ? provider.checkInTime!
//                                 : provider.checkOutTime!,
//                       ),
//                 ),
//               );
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("QR Failed: ${result.message}")),
//               );
//               _scanned = false; // allow retry
//             }
//           } catch (e) {
//             if (!mounted) return;
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text("Error: $e")));
//             _scanned = false;
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scannerController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/providers/checkin_card_controller.dart';
import 'package:ziya_attendence_app/viewModels/auth_view_models/login_viewmodel.dart';
import 'punch_in_out_success_screen.dart';

class QrVerificationScreen extends StatefulWidget {
  final bool isCheckIn;

  const QrVerificationScreen({super.key, required this.isCheckIn});

  @override
  State<QrVerificationScreen> createState() => _QrVerificationScreenState();
}

class _QrVerificationScreenState extends State<QrVerificationScreen> {
  bool _scanned = false;
  late final MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginVm = Provider.of<LoginViewModel>(context, listen: false);
    final userId = loginVm.userId;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCheckIn ? "QR Check-In" : "QR Check-Out"),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _scannerController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => _scannerController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: _scannerController,
        onDetect: (BarcodeCapture capture) async {
          if (_scanned) return; // prevent multiple triggers
          final code = capture.barcodes.first.rawValue;
          if (code == null || code.isEmpty || userId == null) return;

          _scanned = true;
          final provider = Provider.of<AttendanceProvider>(
            context,
            listen: false,
          );

          try {
            final result =
                widget.isCheckIn
                    ? await provider.checkInWithQr(code, userId)
                    : await provider.checkOutWithQr(code, userId);

            if (!mounted) return;

            if (result.success) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => PunchInOutSuccessScreen(
                        checkedIn: widget.isCheckIn,
                        time:
                            widget.isCheckIn
                                ? provider.checkInTime!
                                : provider.checkOutTime!,
                      ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("QR Failed: ${result.message}")),
              );
              _scanned = false; // allow retry
            }
          } catch (e) {
            if (!mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: $e")));
            _scanned = false;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }
}
