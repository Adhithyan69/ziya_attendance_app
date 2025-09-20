import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/services/auth_services/auth_service.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String _newPassword = "";
  String _confirmPassword = "";
  String? _errorMessage;
  bool _isLoading = false;
  bool _isSuccess = false;

  // ✅ Getters
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;

  // ✅ Input handlers
  void onNewPasswordChanged(String value) {
    _newPassword = value.trim();
    notifyListeners();
  }

  void onConfirmPasswordChanged(String value) {
    _confirmPassword = value.trim();
    notifyListeners();
  }

  // ✅ Reset Password (via service)
  Future<void> resetPassword(String email) async {
    if (_newPassword.isEmpty || _confirmPassword.isEmpty) {
      _errorMessage = "Please fill all fields";
      _isSuccess = false;
      notifyListeners();
      return;
    }

    if (_newPassword != _confirmPassword) {
      _errorMessage = "Passwords do not match";
      _isSuccess = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    final result = await _authService.resetPassword(email, _newPassword);

    _isLoading = false;
    if (result.success) {
      _isSuccess = true;
      _errorMessage = null;
    } else {
      _isSuccess = false;
      _errorMessage = result.error ?? "Password reset failed";
    }
    notifyListeners();
  }
}
