class VerifyResetDto {
  final bool success;
  final String message;
  final String? resetToken;  

  VerifyResetDto({
    required this.success,
    required this.message,
    this.resetToken,
  });

  factory VerifyResetDto.fromJson(Map<String, dynamic> json) {
    return VerifyResetDto(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      resetToken: json['data']?['resetToken'] ?? json['resetToken'],
    );
  }
}