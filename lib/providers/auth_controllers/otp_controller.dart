import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpController extends ChangeNotifier {
  String _otp = "";
  bool _isLoading = false;
  String? _errorMessage;

  String get otp => _otp;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void onOtpChange(String newOtp) {
    if (newOtp.length <= 4) {
      _otp = newOtp;
      notifyListeners();
    }
  }

  Future<void> verifyOtp(String email, Function onSuccess) async {
    if (_otp.length < 4) {
      _errorMessage = "Enter 4 digit code";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.44:8000/api/verify-otp/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": _otp}),
      );

      _isLoading = false;
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        onSuccess();
      } else {
        _errorMessage = data["error"] ?? "Invalid code";
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Error: $e";
    }

    notifyListeners();
  }

  Future<void> resendCode(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.44:8000/api/resend-otp/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      final data = jsonDecode(response.body);
      _errorMessage = data["message"] ?? "New OTP sent";
    } catch (e) {
      _errorMessage = "Error: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}
