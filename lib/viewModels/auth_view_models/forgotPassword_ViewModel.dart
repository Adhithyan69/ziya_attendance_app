import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/services/auth_services/auth_service.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Map<String, dynamic>> resetPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.forgotPassword(email);

    _isLoading = false;
    notifyListeners();

    return result;
  }
}
