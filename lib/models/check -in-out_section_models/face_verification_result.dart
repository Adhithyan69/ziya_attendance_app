class FaceVerificationResult {
  final bool success;
  final String? message;

  FaceVerificationResult({required this.success, this.message});

  factory FaceVerificationResult.fromJson(Map<String, dynamic> json) {
    return FaceVerificationResult(
      success: json['success'] ?? false,
      message: json['message'],
    );
  }
}
