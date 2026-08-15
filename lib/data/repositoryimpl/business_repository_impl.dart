
import 'package:dio/dio.dart';
import 'package:hesabuapp/data/dtos/business_dto.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/business.dart';
import 'package:hesabuapp/domain/repositories/business_repository.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final ApiClient apiClient;
  final SharedPreference sharedPreference;
  final UserService userService;

  BusinessRepositoryImpl(
    this.apiClient,
    this.sharedPreference,
    this.userService,
  );

  @override
  Future<List<Business>> getBusinesses() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoint.businesses);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data
            .map((json) => BusinessDto.fromJson(json as Map<String, dynamic>).toDomain())
            .toList();
      } else {
        throw Exception('Failed to load businesses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load businesses: $e');
    }
  }

  @override
  Future<Business> getBusinessById(String id) async {
    try {
      final response = await apiClient.dio.get('${ApiEndpoint.businesses}/$id');

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return BusinessDto.fromJson(data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to load business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load business: $e');
    }
  }

  @override
  Future<Business> createBusiness(CreateBusinessDto dto) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.businesses,
        data: dto.toJson(),
      );

      if (response.statusCode == 201) {
        final data = response.data['data'] ?? response.data;
        return BusinessDto.fromJson(data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to create business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create business: $e');
    }
  }

  @override
  Future<Business> updateBusiness(String id, UpdateBusinessDto dto) async {
    try {
      final response = await apiClient.dio.put(
        '${ApiEndpoint.businesses}/$id',
        data: dto.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return BusinessDto.fromJson(data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to update business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update business: $e');
    }
  }

  @override
  Future<void> deleteBusiness(String id) async {
    try {
      final response = await apiClient.dio.delete('${ApiEndpoint.businesses}/$id');

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Failed to delete business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete business: $e');
    }
  }

  @override
  Future<Business> getCurrentBusiness() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoint.businessesCurrent);

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return BusinessDto.fromJson(data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to get current business: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get current business: $e');
    }
  }
}