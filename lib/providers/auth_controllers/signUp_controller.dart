// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class SignUpController extends ChangeNotifier {
//   Future<void> signUp({
//     required BuildContext context,
//     required Map<String, dynamic> body,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse("http://<your-ip>:8000/api/employee/register/"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(body),
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 201 && data["success"] == true) {
//         showDialog(
//           context: context,
//           builder:
//               (ctx) => AlertDialog(
//                 title: const Text("Success"),
//                 content: Text(data["message"] ?? "Sign up successful!"),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.of(ctx).pop(),
//                     child: const Text("OK"),
//                   ),
//                 ],
//               ),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder:
//               (ctx) => AlertDialog(
//                 title: const Text("Error"),
//                 content: Text(data["errors"].toString()),
//                 actions: [
//                   TextButton(
//                     onPressed: () => Navigator.of(ctx).pop(),
//                     child: const Text("OK"),
//                   ),
//                 ],
//               ),
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder:
//             (ctx) => AlertDialog(
//               title: const Text("Error"),
//               content: Text("Sign up failed: $e"),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(ctx).pop(),
//                   child: const Text("OK"),
//                 ),
//               ],
//             ),
//       );
//     }
//   }
// }
