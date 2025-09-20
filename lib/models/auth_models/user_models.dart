class UserModel {
  final String id;
  final String name;
  final String email;
  final String employeeId; // ✅ new field

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.employeeId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      employeeId: json["employee_id"].toString(), // ✅ map employee_id
    );
  }
}
