import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ziya_attendence_app/constants/text_constants.dart';

class CheckFaceVerificationController extends ChangeNotifier {
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  bool isLoading = false;

  bool isFlashOn = false;
  int selectedCameraIndex = 0;
  bool _isCapturing = false;

  CheckFaceVerificationController() {
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        final frontCamera = cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => cameras!.first,
        );

        selectedCameraIndex = cameras!.indexOf(frontCamera);
        await _initController(frontCamera);
      }
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
    try {
      await cameraController!.initialize();
      notifyListeners();
    } catch (e) {
      debugPrint("CameraController initialization error: $e");
    }
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
    if (_isCapturing) return null;

    try {
      _isCapturing = true;
      final image = await cameraController!.takePicture();
      return File(image.path);
    } catch (e) {
      debugPrint("Error capturing image: $e");
      return null;
    } finally {
      _isCapturing = false;
    }
  }

  Future<bool> verifyFaceAndMarkAttendance(
    BuildContext context,
    File imageFile,
    dynamic userId,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      var uri = Uri.parse("${TextConstants.baseUrl}face/verify/");
      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
      request.fields['user_id'] = userId.toString();

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      debugPrint("Server Response: $responseBody");

      isLoading = false;
      notifyListeners();

      final decoded = json.decode(responseBody);

      if (response.statusCode == 200 && decoded['success'] == true) {
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
