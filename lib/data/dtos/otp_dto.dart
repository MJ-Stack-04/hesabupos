
class OtpDto {
  final bool success;
  final String message;

  OtpDto({
    required this.success,
    required this.message,
  });

  factory OtpDto.fromJson(Map<String, dynamic> json) {
    return OtpDto(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}