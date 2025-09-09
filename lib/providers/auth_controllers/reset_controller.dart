import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordController extends ChangeNotifier {
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

  // ✅ Reset Password API call
  Future<void> resetPassword(String email) async {
    // Validation
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

    // Start loading
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.44:8000/api/reset-password/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "new_password": _newPassword}),
      );

      _isLoading = false;
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        _isSuccess = true;
        _errorMessage = null;
      } else {
        _isSuccess = false;
        _errorMessage = data["error"] ?? "Password reset failed";
      }
    } catch (e) {
      _isLoading = false;
      _isSuccess = false;
      _errorMessage = "Error: $e";
    }

    notifyListeners();
  }
}
