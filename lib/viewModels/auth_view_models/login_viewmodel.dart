// import 'package:flutter/cupertino.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:ziya_attendence_app/constants/text_constants.dart';
// import 'package:ziya_attendence_app/models/auth_models/user_models.dart';
// import 'package:ziya_attendence_app/services/auth_services/auth_service.dart';

// class LoginViewModel extends ChangeNotifier {
//   final AuthService _authService = AuthService();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   // Controllers
//   final TextEditingController emailCtrl = TextEditingController();
//   final TextEditingController passCtrl = TextEditingController();

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   bool _obscurePassword = true;
//   bool get obscurePassword => _obscurePassword;

//   bool _rememberMe = false;
//   bool get rememberMe => _rememberMe;

//   UserModel? _user;
//   UserModel? get user => _user;

//   /// ✅ Getter for userId (will be null if not logged in)
//   String? get userId => _user?.id;

//   LoginViewModel() {
//     _loadSavedCredentials();
//   }

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   void togglePasswordVisibility() {
//     _obscurePassword = !_obscurePassword;
//     notifyListeners();
//   }

//   void toggleRememberMe(bool value) {
//     _rememberMe = value;
//     notifyListeners();
//   }

//   Future<Map<String, dynamic>> login() async {
//     final email = emailCtrl.text.trim();
//     final password = passCtrl.text.trim();

//     _setLoading(true);
//     try {
//       final result = await _authService.login(email, password);

//       if (result[TextConstants.success] == true) {
//         _user = result["user"] as UserModel?;

//         // ✅ Save credentials if Remember Me checked
//         if (_rememberMe) {
//           await _secureStorage.write(key: "email", value: email);
//           await _secureStorage.write(key: "password", value: password);
//         } else {
//           await _secureStorage.deleteAll();
//         }

//         notifyListeners();
//       }
//       return result;
//     } catch (e) {
//       return {
//         TextConstants.success: false,
//         TextConstants.message: e.toString(),
//       };
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> _loadSavedCredentials() async {
//     final savedEmail = await _secureStorage.read(key: "email");
//     final savedPassword = await _secureStorage.read(key: "password");

//     emailCtrl.text = savedEmail ?? "";
//     passCtrl.text = savedPassword ?? "";
//     _rememberMe = savedEmail != null && savedPassword != null;

//     notifyListeners();
//   }

//   void logout() {
//     _user = null;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     emailCtrl.dispose();
//     passCtrl.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/models/auth_models/user_models.dart';
import 'package:ziya_attendence_app/services/auth_services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Controllers
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  bool _rememberMe = false;
  bool get rememberMe => _rememberMe;

  UserModel? _user;
  UserModel? get user => _user;

  /// ✅ Getters for IDs
  String? get userId => _user?.id;
  String? get employeeId => _user?.employeeId;

  LoginViewModel() {
    _loadSavedCredentials();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login() async {
    final email = emailCtrl.text.trim();
    final password = passCtrl.text.trim();

    _setLoading(true);
    try {
      final result = await _authService.login(email, password);

      if (result[TextConstants.success] == true) {
        _user = result["user"] as UserModel?;

        if (_rememberMe) {
          await _secureStorage.write(key: "email", value: email);
          await _secureStorage.write(key: "password", value: password);
        } else {
          await _secureStorage.deleteAll();
        }

        notifyListeners();
      }
      return result;
    } catch (e) {
      return {
        TextConstants.success: false,
        TextConstants.message: e.toString(),
      };
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadSavedCredentials() async {
    final savedEmail = await _secureStorage.read(key: "email");
    final savedPassword = await _secureStorage.read(key: "password");

    emailCtrl.text = savedEmail ?? "";
    passCtrl.text = savedPassword ?? "";
    _rememberMe = savedEmail != null && savedPassword != null;

    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }
}
