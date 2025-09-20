// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:ziya_attendence_app/services/check-in-out_section_services/qr_code_verification_service.dart';

// class QrVerificationViewModel extends ChangeNotifier {
//   final QrVerificationService _service = QrVerificationService();

//   bool isLoading = false;
//   String? errorMessage;

//   Future<Response?> punchIn({
//     required String qrCode,
//     required double latitude,
//     required double longitude,
//   }) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       final response = await _service.punchInWithQR(
//         qrCode: qrCode,
//         latitude: latitude,
//         longitude: longitude,
//       );
//       return response;
//     } catch (e) {
//       errorMessage = e.toString();
//       return null;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<Response?> punchOut({
//     required String qrCode,
//     required double latitude,
//     required double longitude,
//     int? attendanceId,
//   }) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       final response = await _service.punchOutWithQR(
//         qrCode: qrCode,
//         latitude: latitude,
//         longitude: longitude,
//         attendanceId: attendanceId,
//       );
//       return response;
//     } catch (e) {
//       errorMessage = e.toString();
//       return null;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // 👈 use Dio Response, not http
import 'package:ziya_attendence_app/services/check-in-out_section_services/qr_code_verification_service.dart';

class QrVerificationViewModel extends ChangeNotifier {
  final QrVerificationService _service = QrVerificationService();

  bool isLoading = false;
  String? errorMessage;

  /// ✅ Punch In using QR + employee_id
  Future<Response?> punchIn({
    required String qrCode,
    required String employeeId,
    required double latitude,
    required double longitude,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final Response response = await _service.punchInWithQR(
        qrCode: qrCode,
        employeeId: employeeId, // ✅ employee_id expected by backend
        latitude: latitude,
        longitude: longitude,
      );
      return response;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ Punch Out using QR + employee_id
  Future<Response?> punchOut({
    required String qrCode,
    required String employeeId,
    required double latitude,
    required double longitude,
    int? attendanceId,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final Response response = await _service.punchOutWithQR(
        qrCode: qrCode,
        employeeId: employeeId,
        latitude: latitude,
        longitude: longitude,
        attendanceId: attendanceId,
      );
      return response;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
