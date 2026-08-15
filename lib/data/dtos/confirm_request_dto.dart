class ConfirmResetDto {
  final bool success;
  final String message;
  final String? accessToken;

  ConfirmResetDto({
    required this.success,
    required this.message,
    this.accessToken,
  });

  factory ConfirmResetDto.fromJson(Map<String, dynamic> json) {
    return ConfirmResetDto(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      accessToken: json['accessToken'] ?? json['token'] ?? json['_token'],
    );
  }
}