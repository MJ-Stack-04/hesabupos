
import 'package:dio/dio.dart';
import 'package:hesabuapp/data/dtos/branch_dto.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/branch.dart';
import 'package:hesabuapp/domain/repositories/branch_repository.dart';

class BranchRepositoryImpl implements BranchRepository {
  final ApiClient apiClient;
  final SharedPreference sharedPreference;
  final UserService userService;

  BranchRepositoryImpl(
    this.apiClient,
    this.sharedPreference,
    this.userService,
  );

  @override
  Future<List<Branch>> getBranches() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoint.branches);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? response.data;
        return data
            .map((json) => BranchDto.fromJson(json as Map<String, dynamic>).toDomain())
            .toList();
      } else {
        throw Exception('Failed to load branches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load branches: $e');
    }
  }

  @override
  Future<Branch> getBranchById(String id) async {
    try {
      final response = await apiClient.dio.get('${ApiEndpoint.branches}/$id');

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return BranchDto.fromJson(data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to load branch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load branch: $e');
    }
  }

  @override
  Future<Branch> createBranch(CreateBranchDto dto) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.branches,
        data: dto.toJson(),
      );

      if (response.statusCode == 201) {
        final data = response.data['data'] ?? response.data;
        return BranchDto.fromJson(data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to create branch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create branch: $e');
    }
  }

  @override
  Future<Branch> updateBranch(String id, UpdateBranchDto dto) async {
    try {
      final response = await apiClient.dio.put(
        '${ApiEndpoint.branches}/$id',
        data: dto.toJson(),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return BranchDto.fromJson(data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to update branch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update branch: $e');
    }
  }

  @override
  Future<void> deleteBranch(String id) async {
    try {
      final response = await apiClient.dio.delete('${ApiEndpoint.branches}/$id');

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Failed to delete branch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete branch: $e');
    }
  }

  @override
  Future<Branch> getCurrentBranch() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoint.branchesCurrent);

      if (response.statusCode == 200) {
        final data = response.data['data'] ?? response.data;
        return BranchDto.fromJson(data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to get current branch: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get current branch: $e');
    }
  }
}