class ResetResponseModel {
  final bool success;
  final String? error;

  ResetResponseModel({required this.success, this.error});

  factory ResetResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetResponseModel(
      success: json["success"] ?? false,
      error: json["error"],
    );
  }
}
