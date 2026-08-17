import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/data/dtos/auth_dto.dart';
import 'package:hesabuapp/data/dtos/branch_dto.dart';
import 'package:hesabuapp/data/dtos/business_dto.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/auth.dart';
import 'package:hesabuapp/domain/entities/branch.dart';
import 'package:hesabuapp/domain/entities/business.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final SharedPreference sharedPreference;
  final UserService userService;

  AuthRepositoryImpl(this.apiClient, this.sharedPreference, this.userService);

  @override
  Future<Auth> login(String email, String password) async {
    try {
      final request = AuthDto.fromRequest(email: email, password: password);

      final response = await apiClient.dio.post(
        ApiEndpoint.login,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthDto.fromJson(
          response.data as Map<String, dynamic>,
        );

        if (!authResponse.success) {
          throw Exception(authResponse.message);
        }

        final auth = authResponse.toDomain();

        sharedPreference.saveToken(auth.token);
        sharedPreference.saveRefreshToken(auth.refreshToken);
        sharedPreference.saveUserId(auth.user.id);
        sharedPreference.saveUserFirstName(auth.user.firstName);
        sharedPreference.saveUserLastName(auth.user.lastName);
        sharedPreference.saveUserEmail(auth.user.email);

        userService.setUser(
          firstName: auth.user.firstName,
          lastName: auth.user.lastName,
          email: auth.user.email,
          phone: auth.user.phone,
          userId: auth.user.id,
        );

        apiClient.setAuthToken(auth.token);

        return auth;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      }
      throw Exception('Network error. Check your internet connection.');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<Auth> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phone,
  ) async {
    try {
      final request = AuthDto.fromRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );

      final response = await apiClient.dio.post(
        ApiEndpoint.register,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final authResponse = AuthDto.fromJson(
          response.data as Map<String, dynamic>,
        );

        if (!authResponse.success) {
          throw Exception(authResponse.message);
        }

        final auth = authResponse.toDomain();

        sharedPreference.saveToken(auth.token);
        sharedPreference.saveRefreshToken(auth.refreshToken);
        sharedPreference.saveUserId(auth.user.id);
        sharedPreference.saveUserFirstName(auth.user.firstName);
        sharedPreference.saveUserLastName(auth.user.lastName);
        sharedPreference.saveUserEmail(auth.user.email);

        userService.setUser(
          firstName: auth.user.firstName,
          lastName: auth.user.lastName,
          email: auth.user.email,
          phone: auth.user.phone,
          userId: auth.user.id,
        );

        apiClient.setAuthToken(auth.token);

        return auth;
      } else {
        throw Exception('Registration failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? 'Registration failed');
      }
      throw Exception('Network error. Check your internet connection.');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.dio.post(ApiEndpoint.logout);
    } finally {
      apiClient.removeAuthToken();
      userService.clearUser();
      sharedPreference.clearAll();
    }
  }

  @override
  Future<void> switchBranch(String branchId) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.branchesSwitch,
        data: {'branchId': branchId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;

        if (data['success'] == false) {
          throw Exception(data['message'] ?? 'Failed to switch branch');
        }

        final tokens = data['data'];
        final accessToken = tokens['accessToken'];
        final refreshToken = tokens['refreshToken'];

        sharedPreference.saveToken(accessToken);
        sharedPreference.saveRefreshToken(refreshToken);
      } else {
        throw Exception('Failed to switch branch: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to switch branch',
        );
      }
      throw Exception('Network error. Check your internet connection.');
    } catch (e) {
      throw Exception('Failed to switch branch: $e');
    }
  }

  @override
  Future<Business> switchBusiness(String businessId) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.businessesSwitch,
        data: {'businessId': businessId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;

        if (data['success'] == false) {
          throw Exception(data['message'] ?? 'Failed to switch business');
        }

        final businessData = data['data']?['business'] ?? data['data'] ?? data;
        final business = BusinessDto.fromJson(
          businessData as Map<String, dynamic>,
        ).toDomain();

        if (data['data']?['accessToken'] != null) {
          final newToken = data['data']['accessToken'] as String;
          apiClient.setAuthToken(newToken);
          sharedPreference.saveToken(newToken);
        }

        if (data['data']?['refreshToken'] != null) {
          sharedPreference.saveRefreshToken(
            data['data']['refreshToken'] as String,
          );
        }

        userService.setBusiness(
          businessId: business.id,
          businessName: business.name,
        );

        return business;
      } else {
        throw Exception('Failed to switch business: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        throw Exception(
          e.response?.data['message'] ?? 'Failed to switch business',
        );
      }
      throw Exception('Network error. Check your internet connection.');
    } catch (e) {
      throw Exception('Failed to switch business: $e');
    }
  }
}
