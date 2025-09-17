import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/models/auth_models/user_models.dart';

class AuthService {
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
}
