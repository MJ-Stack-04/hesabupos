
class RequestResetDto {
  final bool success;
  final String message;

  RequestResetDto({
    required this.success,
    required this.message,
  });

  factory RequestResetDto.fromJson(Map<String, dynamic> json) {
    return RequestResetDto(
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

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'resetToken': resetToken,
    };
  }
}

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

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'accessToken': accessToken,
    };
  }
}