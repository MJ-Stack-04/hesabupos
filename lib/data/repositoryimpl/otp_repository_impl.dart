
import 'package:dio/dio.dart';
import 'package:hesabuapp/data/dtos/otp_dto.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/domain/repositories/otp_repository.dart';

class OtpRepositoryImpl implements OtpRepository {
  final ApiClient apiClient;

  OtpRepositoryImpl(this.apiClient);

  @override
  Future<void> sendOtp(String email) async {
    if (email.isEmpty) {
      throw Exception('Email address is required');
    }

    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.verifications,
        data: {
          'to': email,
          'channel': 'email',
        },
      );

      final responseData = OtpDto.fromJson(response.data as Map<String, dynamic>);

      if (!responseData.success) {
        throw Exception(responseData.message);
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to send OTP');
      }
      throw Exception('Network error. Check your internet connection.');
    }
  }

  @override
  Future<bool> verifyOtp(String code, String email) async {
    if (email.isEmpty) {
      throw Exception('Email address is required');
    }

    if (code.isEmpty) {
      throw Exception('Verification code is required');
    }

    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.verificationsCheck,
        data: {
          'to': email,
          'token': code,
        },
      );

      final responseData = OtpDto.fromJson(response.data as Map<String, dynamic>);

      if (!responseData.success) {
        throw Exception(responseData.message);
      }

      return true;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Invalid OTP code');
      }
      throw Exception('Network error. Check your internet connection.');
    }
  }
}