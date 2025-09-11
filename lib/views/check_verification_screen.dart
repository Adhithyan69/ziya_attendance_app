import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/providers/auth_controllers/login_controller.dart';
import 'package:ziya_attendence_app/providers/dashboard_controllers/check_face_verification_controller.dart';
import 'package:ziya_attendence_app/views/punch_in_out_success_screen.dart';

class CheckVerificationScreen extends StatefulWidget {
  const CheckVerificationScreen({
    super.key,
    required this.time,
    required this.checkedIn,
    required this.onsite,
  });

  final String time;
  final bool checkedIn;
  final bool onsite;

  @override
  State<CheckVerificationScreen> createState() =>
      _CheckVerificationScreenState();
}

class _CheckVerificationScreenState extends State<CheckVerificationScreen> {
  late CheckFaceVerificationController faceProvider;

  @override
  void initState() {
    super.initState();
    faceProvider = CheckFaceVerificationController();
  }

  @override
  void dispose() {
    faceProvider.disposeCamera();
    faceProvider.dispose();
    super.dispose();
  }

  Future<void> _captureAndVerify(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final userId = loginProvider.userData?['id'];

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User not logged in!")));
      return;
    }

    File? image = await faceProvider.captureImage();
    if (image != null) {
      bool success = await faceProvider.verifyFaceAndMarkAttendance(
        context,
        image,
        userId,
        widget.onsite,
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (_) => PunchInOutSuccessScreen(
                  time: widget.time,
                  checkedIn: !widget.checkedIn, // toggle check-in/out properly
                ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Face verification failed!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckFaceVerificationController>.value(
      value: faceProvider,
      child: Consumer<CheckFaceVerificationController>(
        builder: (context, provider, child) {
          if (provider.cameraController == null ||
              !provider.cameraController!.value.isInitialized) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(provider.cameraController!),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: const [
                      Text(
                        TextConstants.centerYourFace,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        TextConstants.checkVerifcnText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.only(bottom: 30),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child:
                        provider.isLoading
                            ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(
                                      provider.isFlashOn
                                          ? Icons.flash_on
                                          : Icons.flash_off,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    onPressed: provider.toggleFlash,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    onPressed: () => _captureAndVerify(context),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.cameraswitch,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    onPressed: provider.switchCamera,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
