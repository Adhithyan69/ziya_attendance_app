// // import 'package:flutter/material.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:intl/intl.dart';
// // import 'package:network_info_plus/network_info_plus.dart';

// // class AttendanceProvider extends ChangeNotifier {
// //   String? checkInTime;
// //   String? checkOutTime;
// //   bool isCheckedIn = false;
// //   bool isOnsite = true;

// //   String? location;
// //   String? deviceIp;

// //   /// Set work mode (onsite / remote)
// //   void setWorkMode(bool onsite) {
// //     isOnsite = onsite;
// //     notifyListeners();
// //   }

// //   Future<String> _getLocation() async {
// //     try {
// //       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //       if (!serviceEnabled) return "Location Disabled";

// //       LocationPermission permission = await Geolocator.checkPermission();
// //       if (permission == LocationPermission.denied) {
// //         permission = await Geolocator.requestPermission();
// //         if (permission == LocationPermission.denied) {
// //           return "Permission Denied";
// //         }
// //       }
// //       if (permission == LocationPermission.deniedForever) {
// //         return "Permission Permanently Denied";
// //       }

// //       // Get coordinates
// //       Position pos = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );

// //       // Reverse geocoding to get address
// //       List<Placemark> placemarks = await placemarkFromCoordinates(
// //         pos.latitude,
// //         pos.longitude,
// //       );

// //       if (placemarks.isNotEmpty) {
// //         final p = placemarks.first;
// //         return "${p.locality},${p.administrativeArea}";
// //       } else {
// //         return "${pos.latitude}, ${pos.longitude}";
// //       }
// //     } catch (e) {
// //       return "Location Error";
// //     }
// //   }

// //   /// Fetch local device IP
// //   Future<String> _getDeviceIp() async {
// //     try {
// //       final info = NetworkInfo();
// //       final wifiIP = await info.getWifiIP();
// //       return wifiIP ?? "Unknown IP";
// //     } catch (e) {
// //       return "IP Error";
// //     }
// //   }

// //   /// Check-in
// //   Future<bool> checkIn() async {
// //     if (isCheckedIn) {
// //       debugPrint("⚠️ Already checked in, ignoring new check-in.");
// //       return false;
// //     }

// //     checkInTime = DateFormat('hh:mm a').format(DateTime.now());
// //     checkOutTime = null; // reset
// //     location = await _getLocation();
// //     deviceIp = await _getDeviceIp();

// //     isCheckedIn = true;
// //     notifyListeners();

// //     debugPrint(
// //       "✅ Checked in at $checkInTime | $location | $deviceIp | Mode: ${isOnsite ? "Onsite" : "WFH"}",
// //     );
// //     return true;
// //   }

// //   /// Check-out
// //   Future<bool> checkOut() async {
// //     if (!isCheckedIn) {
// //       debugPrint("⚠️ Not checked in, cannot check out.");
// //       return false;
// //     }

// //     checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
// //     location = await _getLocation();
// //     deviceIp = await _getDeviceIp();

// //     isCheckedIn = false;
// //     notifyListeners();

// //     debugPrint(
// //       "✅ Checked out at $checkOutTime | $location | $deviceIp | Mode: ${isOnsite ? "Onsite" : "WFH"}",
// //     );
// //     return true;
// //   }
// // }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:ziya_attendence_app/models/check%20-in-out_section_models/face_verification_result.dart';
// import 'package:ziya_attendence_app/services/check-in-out_section_services/face_verification_service.dart';
// import 'package:ziya_attendence_app/services/check-in-out_section_services/qr_code_verification_service.dart';

// class AttendanceProvider extends ChangeNotifier {
//   String? checkInTime;
//   String? checkOutTime;
//   bool isCheckedIn = false;
//   bool isOnsite = true;

//   String? location;
//   String? deviceIp;

//   final PunchInService _punchInService = PunchInService();
//   final FaceVerificationService _faceService = FaceVerificationService();

//   /// Set work mode (onsite / remote)
//   void setWorkMode(bool onsite) {
//     isOnsite = onsite;
//     notifyListeners();
//   }

//   /// ✅ Get current geolocation
//   Future<Position?> _getCoordinates() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) return null;

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           return null;
//         }
//       }
//       if (permission == LocationPermission.deniedForever) {
//         return null;
//       }

//       return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//     } catch (e) {
//       debugPrint("Location error: $e");
//       return null;
//     }
//   }

//   /// ✅ Fetch local device IP
//   Future<String?> _getDeviceIp() async {
//     try {
//       final info = NetworkInfo();
//       return await info.getWifiIP();
//     } catch (e) {
//       return null;
//     }
//   }

//   /// ✅ Manual Check-in (fallback)
//   Future<bool> checkIn() async {
//     if (isCheckedIn) return false;

//     checkInTime = DateFormat('hh:mm a').format(DateTime.now());
//     checkOutTime = null;
//     deviceIp = await _getDeviceIp();

//     isCheckedIn = true;
//     notifyListeners();
//     return true;
//   }

//   /// ✅ Manual Check-out (fallback)
//   Future<bool> checkOut() async {
//     if (!isCheckedIn) return false;

//     checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
//     deviceIp = await _getDeviceIp();

//     isCheckedIn = false;
//     notifyListeners();
//     return true;
//   }

//   /// ✅ Punch-in via QR
//   Future<Response> punchInWithQR(String qrCode) async {
//     final pos = await _getCoordinates();
//     if (pos == null) {
//       throw Exception("Location unavailable");
//     }

//     final response = await _punchInService.punchInWithQR(
//       qrCode: qrCode,
//       latitude: pos.latitude,
//       longitude: pos.longitude,
//     );

//     if (response.statusCode == 200) {
//       checkInTime = DateFormat('hh:mm a').format(DateTime.now());
//       isCheckedIn = true;
//       notifyListeners();
//     }
//     return response;
//   }

//   /// ✅ Punch-out via QR
//   Future<Response> punchOutWithQR(String qrCode, {int? attendanceId}) async {
//     final pos = await _getCoordinates();
//     if (pos == null) {
//       throw Exception("Location unavailable");
//     }

//     final response = await _punchInService.punchOutWithQR(
//       qrCode: qrCode,
//       latitude: pos.latitude,
//       longitude: pos.longitude,
//       attendanceId: attendanceId,
//     );

//     if (response.statusCode == 200) {
//       checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
//       isCheckedIn = false;
//       notifyListeners();
//     }
//     return response;
//   }

//   /// ✅ Verify face before allowing punch in/out
//   Future<FaceVerificationResult> verifyFaceAndCheck({
//     required String userId,
//     required File imageFile,
//     required bool checkInMode,
//   }) async {
//     final result = await _faceService.verifyFace(
//       imageFile: imageFile,
//       userId: userId,
//     );

//     if (result.success) {
//       if (checkInMode) {
//         await checkIn();
//       } else {
//         await checkOut();
//       }
//     }

//     return result;
//   }
// }
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:intl/intl.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:ziya_attendence_app/models/check%20-in-out_section_models/face_verification_result.dart';
// import 'package:ziya_attendence_app/models/check%20-in-out_section_models/qr_verification_result.dart';
// import 'package:ziya_attendence_app/services/check-in-out_section_services/qr_code_verification_service.dart';
// import 'package:ziya_attendence_app/services/check-in-out_section_services/face_verification_service.dart';
// import 'package:dio/dio.dart';

// class AttendanceProvider extends ChangeNotifier {
//   String? checkInTime;
//   String? checkOutTime;
//   bool isCheckedIn = false;
//   bool isOnsite = true;
//   String? location;
//   String? deviceIp;

//   double? latitude;
//   double? longitude;

//   final FaceVerificationService _faceService = FaceVerificationService();
//   final QrVerificationService _qrService = QrVerificationService();

//   void setWorkMode(bool onsite) {
//     isOnsite = onsite;
//     notifyListeners();
//   }

//   Future<String> _getLocation() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) return "Location Disabled";

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) return "Permission Denied";
//       }
//       if (permission == LocationPermission.deniedForever) {
//         return "Permission Permanently Denied";
//       }

//       Position pos = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       latitude = pos.latitude;
//       longitude = pos.longitude;

//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         pos.latitude,
//         pos.longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         final p = placemarks.first;
//         return "${p.locality}, ${p.administrativeArea}";
//       } else {
//         return "${pos.latitude},${pos.longitude}";
//       }
//     } catch (_) {
//       return "Location Error";
//     }
//   }

//   Future<String> _getDeviceIp() async {
//     try {
//       final info = NetworkInfo();
//       final wifiIP = await info.getWifiIP();
//       return wifiIP ?? "Unknown IP";
//     } catch (_) {
//       return "IP Error";
//     }
//   }

//   Future<void> _setCheckIn() async {
//     checkInTime = DateFormat('hh:mm a').format(DateTime.now());
//     checkOutTime = null;
//     location = await _getLocation();
//     deviceIp = await _getDeviceIp();
//     isCheckedIn = true;
//     notifyListeners();
//   }

//   Future<void> _setCheckOut() async {
//     checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
//     location = await _getLocation();
//     deviceIp = await _getDeviceIp();
//     isCheckedIn = false;
//     notifyListeners();
//   }

//   /// ✅ Face check-in/out
//   Future<FaceVerificationResult> verifyFaceAndCheck({
//     required String userId,
//     required File imageFile,
//     required bool checkInMode,
//   }) async {
//     final result = await _faceService.verifyFace(
//       imageFile: imageFile,
//       userId: userId,
//     );

//     if (result.success) {
//       checkInMode ? await _setCheckIn() : await _setCheckOut();
//     }
//     return result;
//   }

//   /// ✅ QR check-in
//   Future<QrVerificationResult> checkInWithQr(String qrCode) async {
//     await _getLocation(); // updates latitude/longitude
//     final Response res = await _qrService.punchInWithQR(
//       qrCode: qrCode,
//       latitude: latitude ?? 0.0,
//       longitude: longitude ?? 0.0,
//     );

//     if (res.statusCode == 200) {
//       await _setCheckIn();
//       return QrVerificationResult(success: true, message: "Check-in success");
//     } else {
//       return QrVerificationResult(
//         success: false,
//         message: res.data?['message'] ?? "Check-in failed",
//       );
//     }
//   }

//   /// ✅ QR check-out
//   Future<QrVerificationResult> checkOutWithQr(
//     String qrCode, {
//     int? attendanceId,
//   }) async {
//     await _getLocation();
//     final Response res = await _qrService.punchOutWithQR(
//       qrCode: qrCode,
//       latitude: latitude ?? 0.0,
//       longitude: longitude ?? 0.0,
//       attendanceId: attendanceId,
//     );

//     if (res.statusCode == 200) {
//       await _setCheckOut();
//       return QrVerificationResult(success: true, message: "Check-out success");
//     } else {
//       return QrVerificationResult(
//         success: false,
//         message: res.data?['message'] ?? "Check-out failed",
//       );
//     }
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ziya_attendence_app/models/check%20-in-out_section_models/face_verification_result.dart';
import 'package:ziya_attendence_app/models/check%20-in-out_section_models/qr_verification_result.dart';
import 'package:ziya_attendence_app/services/check-in-out_section_services/qr_code_verification_service.dart';
import 'package:ziya_attendence_app/services/check-in-out_section_services/face_verification_service.dart';
import 'package:dio/dio.dart';

class AttendanceProvider extends ChangeNotifier {
  String? checkInTime;
  String? checkOutTime;
  bool isCheckedIn = false;
  bool isOnsite = true;
  String? location;
  String? deviceIp;

  double? latitude;
  double? longitude;

  final FaceVerificationService _faceService = FaceVerificationService();
  final QrVerificationService _qrService = QrVerificationService();

  void setWorkMode(bool onsite) {
    isOnsite = onsite;
    notifyListeners();
  }

  Future<String> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return "Location Disabled";

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return "Permission Denied";
      }
      if (permission == LocationPermission.deniedForever) {
        return "Permission Permanently Denied";
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = pos.latitude;
      longitude = pos.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return "${p.locality}, ${p.administrativeArea}";
      } else {
        return "${pos.latitude},${pos.longitude}";
      }
    } catch (_) {
      return "Location Error";
    }
  }

  Future<String> _getDeviceIp() async {
    try {
      final info = NetworkInfo();
      final wifiIP = await info.getWifiIP();
      return wifiIP ?? "Unknown IP";
    } catch (_) {
      return "IP Error";
    }
  }

  Future<void> _setCheckIn() async {
    checkInTime = DateFormat('hh:mm a').format(DateTime.now());
    checkOutTime = null;
    location = await _getLocation();
    deviceIp = await _getDeviceIp();
    isCheckedIn = true;
    notifyListeners();
  }

  Future<void> _setCheckOut() async {
    checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
    location = await _getLocation();
    deviceIp = await _getDeviceIp();
    isCheckedIn = false;
    notifyListeners();
  }

  /// ✅ Face check-in/out
  Future<FaceVerificationResult> verifyFaceAndCheck({
    required String userId,
    required File imageFile,
    required bool checkInMode,
  }) async {
    final result = await _faceService.verifyFace(
      imageFile: imageFile,
      userId: userId, // ✅ send user_id to backend
    );

    if (result.success) {
      checkInMode ? await _setCheckIn() : await _setCheckOut();
    }
    return result;
  }

  /// ✅ QR check-in (with employeeId)
  Future<QrVerificationResult> checkInWithQr(
    String qrCode,
    String employeeId,
  ) async {
    await _getLocation(); // updates latitude/longitude
    final Response res = await _qrService.punchInWithQR(
      qrCode: qrCode,
      employeeId: employeeId,
      latitude: latitude ?? 0.0,
      longitude: longitude ?? 0.0,
    );

    if (res.statusCode == 200) {
      await _setCheckIn();
      return QrVerificationResult(success: true, message: "Check-in success");
    } else {
      return QrVerificationResult(
        success: false,
        message: res.data?['message'] ?? "Check-in failed",
      );
    }
  }

  /// ✅ QR check-out (with employeeId)
  Future<QrVerificationResult> checkOutWithQr(
    String qrCode,
    String employeeId, {
    int? attendanceId,
  }) async {
    await _getLocation();
    final Response res = await _qrService.punchOutWithQR(
      qrCode: qrCode,
      employeeId: employeeId,
      latitude: latitude ?? 0.0,
      longitude: longitude ?? 0.0,
      attendanceId: attendanceId,
    );

    if (res.statusCode == 200) {
      await _setCheckOut();
      return QrVerificationResult(success: true, message: "Check-out success");
    } else {
      return QrVerificationResult(
        success: false,
        message: res.data?['message'] ?? "Check-out failed",
      );
    }
  }
}
