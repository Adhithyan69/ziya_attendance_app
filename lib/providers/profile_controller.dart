import 'package:flutter/material.dart';
import 'package:ziya_attendence_app/constants/text_constants.dart';
import '../models/profile_model.dart';

class ProfileController with ChangeNotifier {
  final ProfileModel _profile = ProfileModel(
    name: TextConstants.userName,
    employeeId: TextConstants.empIdNO,
    designation: TextConstants.userDesignation,
    department: TextConstants.departmentName,
  );

  ProfileModel get profile => _profile;
}
