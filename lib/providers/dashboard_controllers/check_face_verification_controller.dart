import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ziya_attendence_app/providers/checkin_card_controller.dart';

class CheckFaceVerificationController extends ChangeNotifier {
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  bool isLoading = false;

  bool isFlashOn = false;
  int selectedCameraIndex = 0;

  CheckFaceVerificationController() {
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      selectedCameraIndex = 0;
      await _initController(cameras![selectedCameraIndex]);
    } catch (e) {
      debugPrint("Camera init error: $e");
    }
  }

  Future<void> _initController(CameraDescription cameraDescription) async {
    await cameraController?.dispose();
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await cameraController!.initialize();
    notifyListeners();
  }

  Future<void> switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;
    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
    await _initController(cameras![selectedCameraIndex]);
  }

  Future<void> toggleFlash() async {
    if (cameraController == null) return;
    try {
      isFlashOn = !isFlashOn;
      await cameraController!.setFlashMode(
        isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      notifyListeners();
    } catch (e) {
      debugPrint("Flash toggle error: $e");
    }
  }

  Future<File?> captureImage() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return null;
    }
    final image = await cameraController!.takePicture();
    return File(image.path);
  }

  /// ✅ Verifies face via API and updates attendance
  Future<bool> verifyFaceAndMarkAttendance(
    BuildContext context,
    File imageFile,
    dynamic userId,
    bool onsite,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://192.168.1.15:8000/api/face-detection/"), // ✅ fixed
      );

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
      request.fields['user_id'] = userId.toString();

      final response = await request.send();

      isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        final attendanceProvider = Provider.of<AttendanceProvider>(
          context,
          listen: false,
        );

        if (!attendanceProvider.isCheckedIn) {
          attendanceProvider.checkIn();
        } else {
          attendanceProvider.checkOut();
        }

        return true;
      }

      return false;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint("API Error: $e");
      return false;
    }
  }

  void disposeCamera() {
    cameraController?.dispose();
  }
}
