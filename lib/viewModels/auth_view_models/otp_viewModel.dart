import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/services/auth_services/auth_service.dart';

class OtpViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String _otp = "";
  bool _isLoading = false;
  String? _errorMessage;

  String get otp => _otp;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Handle OTP input
  void onOtpChange(String newOtp) {
    if (newOtp.length <= 4) {
      _otp = newOtp;
      notifyListeners();
    }
  }

  /// 🔹 Verify OTP
  Future<void> verifyOtp(String email, Function onSuccess) async {
    if (_otp.length < 4) {
      _errorMessage = "Enter 4 digit code";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await _authService.verifyOtp(email, _otp);

    _isLoading = false;
    if (result.success) {
      onSuccess();
    } else {
      _errorMessage = result.error ?? "Invalid code";
    }
    notifyListeners();
  }

  /// 🔹 Resend OTP
  Future<void> resendCode(String email) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.resendOtp(email);

    _isLoading = false;
    _errorMessage = result.message ?? "New OTP sent";
    notifyListeners();
  }
}
