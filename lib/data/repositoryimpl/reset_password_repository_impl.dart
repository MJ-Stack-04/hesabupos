
import 'package:dio/dio.dart';
import 'package:hesabuapp/data/dtos/request_reset_dto.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/domain/repositories/reset_password_repository.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ApiClient apiClient;
  String? _resetToken;

  ResetPasswordRepositoryImpl(this.apiClient);

  @override
  Future<void> requestReset(String email) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.passwordResetRequest,
        data: {'email': email},
      );

      final responseData = RequestResetDto.fromJson(response.data as Map<String, dynamic>);

      if (!responseData.success) {
        throw Exception(responseData.message);
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to send reset link');
      }
      throw Exception('Network error. Check your internet connection.');
    }
  }

  @override
  Future<void> verifyResetOtp(String email, String otp) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.passwordResetVerify,
        data: {
          'email': email,
          'code': otp,
        },
      );

      final responseData = VerifyResetDto.fromJson(response.data as Map<String, dynamic>);

      if (!responseData.success) {
        throw Exception(responseData.message);
      }

      _resetToken = responseData.resetToken;

      if (_resetToken != null && _resetToken!.isNotEmpty) {
        apiClient.setAuthToken(_resetToken!);
      } else {
        throw Exception('No reset token received');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Invalid OTP');
      }
      throw Exception('Network error. Check your internet connection.');
    }
  }

  @override
  Future<void> confirmReset(String email, String otp, String newPassword) async {
    try {
      if (_resetToken == null || _resetToken!.isEmpty) {
        throw Exception('No reset token available. Please verify OTP first.');
      }

      apiClient.setAuthToken(_resetToken!);

      final response = await apiClient.dio.put(
        ApiEndpoint.passwordReset,
        data: {'newPassword': newPassword},
      );

      final responseData = ConfirmResetDto.fromJson(response.data as Map<String, dynamic>);

      if (!responseData.success) {
        throw Exception(responseData.message);
      }

      _resetToken = null;
      apiClient.removeAuthToken();
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to reset password');
      }
      throw Exception('Network error. Check your internet connection.');
    }
  }
}