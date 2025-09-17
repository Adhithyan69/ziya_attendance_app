class OtpResponseModel {
  final bool success;
  final String? message;
  final String? error;

  OtpResponseModel({required this.success, this.message, this.error});

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      success: json["success"] ?? false,
      message: json["message"],
      error: json["error"],
    );
  }
}
