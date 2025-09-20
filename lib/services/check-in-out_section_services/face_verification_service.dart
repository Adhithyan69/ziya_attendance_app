// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:ziya_attendence_app/constants/text_constants.dart';
// import 'package:ziya_attendence_app/models/check%20-in-out_section_models/face_verification_result.dart';

// class FaceVerificationService {
//   Future<FaceVerificationResult> verifyFace({
//     required File imageFile,
//     required String userId,
//   }) async {
//     try {
//       var uri = Uri.parse("${TextConstants.baseUrl}face/verify/");
//       var request = http.MultipartRequest('POST', uri);

//       request.files.add(
//         await http.MultipartFile.fromPath('image', imageFile.path),
//       );
//       request.fields['user_id'] = userId;

//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();

//       if (response.statusCode == 200) {
//         return FaceVerificationResult.fromJson(json.decode(responseBody));
//       } else {
//         return FaceVerificationResult(success: false, message: "Server error");
//       }
//     } catch (e) {
//       return FaceVerificationResult(success: false, message: e.toString());
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ziya_attendence_app/constants/text_constants.dart';
import 'package:ziya_attendence_app/models/check%20-in-out_section_models/face_verification_result.dart';

class FaceVerificationService {
  Future<FaceVerificationResult> verifyFace({
    required File imageFile,
    required String userId,
  }) async {
    try {
      var uri = Uri.parse("${TextConstants.baseUrl}face/verify/");
      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
      request.fields['user_id'] = userId;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return FaceVerificationResult.fromJson(json.decode(responseBody));
      } else {
        return FaceVerificationResult(success: false, message: "Server error");
      }
    } catch (e) {
      return FaceVerificationResult(success: false, message: e.toString());
    }
  }
}
