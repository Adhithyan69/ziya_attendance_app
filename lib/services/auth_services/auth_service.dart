import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/models/auth_models/user_models.dart';
import 'package:ziya_attendence_app/models/auth_models/otp_Response_model.dart';
import 'package:ziya_attendence_app/models/auth_models/reset_response_model.dart';

class AuthService {
  // ✅ Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse("${TextConstants.baseUrl}login/"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        final user = UserModel.fromJson(data["user"] ?? {});
        return {"success": true, "user": user};
      } else {
        return {
          "success": false,
          "message": data["message"] ?? TextConstants.loginFailed,
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }

  // ✅ Forgot Password
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse("${TextConstants.baseUrl}forgot-password/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {"success": true, "message": data["message"] ?? "OTP sent"};
      } else {
        return {"success": false, "message": data["error"] ?? "Error"};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    }
  }

  // ✅ Verify OTP
  Future<OtpResponseModel> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("${TextConstants.baseUrl}verify-otp/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      final data = jsonDecode(response.body);
      return OtpResponseModel.fromJson(data);
    } catch (e) {
      return OtpResponseModel(success: false, error: "Error: $e");
    }
  }

  // ✅ Resend OTP
  Future<OtpResponseModel> resendOtp(String email) async {
    try {
      final response = await http.post(
        Uri.parse("${TextConstants.baseUrl}resend-otp/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      final data = jsonDecode(response.body);
      return OtpResponseModel.fromJson(data);
    } catch (e) {
      return OtpResponseModel(success: false, error: "Error: $e");
    }
  }

  // ✅ Reset Password
  Future<ResetResponseModel> resetPassword(
    String email,
    String newPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("${TextConstants.baseUrl}reset-password/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "new_password": newPassword}),
      );

      final data = jsonDecode(response.body);
      return ResetResponseModel.fromJson(data);
    } catch (e) {
      return ResetResponseModel(success: false, error: "Error: $e");
    }
  }
}
