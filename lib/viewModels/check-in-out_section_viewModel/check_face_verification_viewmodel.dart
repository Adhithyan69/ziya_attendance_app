// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:ziya_attendence_app/models/check%20-in-out_section_models/face_verification_result.dart';
// import 'package:ziya_attendence_app/services/check-in-out_section_services/face_verification_service.dart';

// class CheckFaceVerificationViewModel extends ChangeNotifier {
//   CameraController? cameraController;
//   List<CameraDescription>? cameras;
//   bool isLoading = false;
//   bool isFlashOn = false;
//   int selectedCameraIndex = 0;
//   bool _isCapturing = false;

//   final FaceVerificationService _service = FaceVerificationService();

//   Future<void> initCamera() async {
//     try {
//       cameras = await availableCameras();
//       if (cameras != null && cameras!.isNotEmpty) {
//         final frontCamera = cameras!.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.front,
//           orElse: () => cameras!.first,
//         );
//         selectedCameraIndex = cameras!.indexOf(frontCamera);
//         await _initController(frontCamera);
//       }
//     } catch (e) {
//       debugPrint("Camera init error: $e");
//     }
//   }

//   Future<void> _initController(CameraDescription cameraDescription) async {
//     await cameraController?.dispose();
//     cameraController = CameraController(
//       cameraDescription,
//       ResolutionPreset.medium,
//       enableAudio: false,
//     );
//     try {
//       await cameraController!.initialize();
//       notifyListeners();
//     } catch (e) {
//       debugPrint("CameraController initialization error: $e");
//     }
//   }

//   Future<void> switchCamera() async {
//     if (cameras == null || cameras!.length < 2) return;
//     selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
//     await _initController(cameras![selectedCameraIndex]);
//   }

//   Future<void> toggleFlash() async {
//     if (cameraController == null) return;
//     try {
//       isFlashOn = !isFlashOn;
//       await cameraController!.setFlashMode(
//         isFlashOn ? FlashMode.torch : FlashMode.off,
//       );
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Flash toggle error: $e");
//     }
//   }

//   Future<File?> captureImage() async {
//     if (cameraController == null || !cameraController!.value.isInitialized)
//       return null;
//     if (_isCapturing) return null;

//     try {
//       _isCapturing = true;
//       final image = await cameraController!.takePicture();
//       return File(image.path);
//     } catch (e) {
//       debugPrint("Error capturing image: $e");
//       return null;
//     } finally {
//       _isCapturing = false;
//     }
//   }

//   Future<FaceVerificationResult> verifyFace(
//     File imageFile,
//     String userId,
//   ) async {
//     isLoading = true;
//     notifyListeners();

//     final result = await _service.verifyFace(
//       imageFile: imageFile,
//       userId: userId,
//     );

//     isLoading = false;
//     notifyListeners();

//     return result;
//   }

//   void disposeCamera() {
//     cameraController?.dispose();
//   }
// }
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/models/check%20-in-out_section_models/face_verification_result.dart';
import 'package:ziya_attendence_app/services/check-in-out_section_services/face_verification_service.dart';

class CheckFaceVerificationViewModel extends ChangeNotifier {
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  bool isLoading = false;
  bool isFlashOn = false;
  int selectedCameraIndex = 0;
  bool _isCapturing = false;

  final FaceVerificationService _service = FaceVerificationService();

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

  Future<FaceVerificationResult> verifyFace(
    File imageFile,
    String userId,
  ) async {
    isLoading = true;
    notifyListeners();

    final result = await _service.verifyFace(
      imageFile: imageFile,
      userId: userId,
    );

    isLoading = false;
    notifyListeners();

    return result;
  }

  void disposeCamera() {
    cameraController?.dispose();
  }
}
