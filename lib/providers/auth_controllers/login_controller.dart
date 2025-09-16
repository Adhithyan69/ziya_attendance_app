import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ziya_attendence_app/constants/text_constants.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Login function with timeout
  Future<Map<String, dynamic>> login(String email, String password) async {
    setLoading(true);

    try {
      final response = await http
          .post(
            Uri.parse("${TextConstants.baseUrl}login/"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 10)); // <--- Timeout

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        _userData = data["user"] ?? data; // Store user info
        notifyListeners();
        return {"success": true, "data": _userData};
      } else {
        return {"success": false, "message": data["message"] ?? "Login failed"};
      }
    } catch (e) {
      return {"success": false, "message": "Error: $e"};
    } finally {
      setLoading(false);
    }
  }

  /// Logout function
  void logout() {
    _userData = null;
    notifyListeners();
  }
}
