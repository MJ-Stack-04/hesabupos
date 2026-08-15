
import 'package:hesabuapp/data/dtos/category_dto.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/domain/entities/category.dart';
import 'package:hesabuapp/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final ApiClient apiClient;
  final SharedPreference sharedPreference;

  CategoryRepositoryImpl(this.apiClient, this.sharedPreference);

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoint.categories);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> categoryList = data['data'] ?? [];
        return categoryList
            .map((json) => CategoryDto.fromJson(json as Map<String, dynamic>).toDomain())
            .toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  @override
  Future<Category> getCategoryById(String id) async {
    try {
      final response = await apiClient.dio.get('${ApiEndpoint.categories}/$id');
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return CategoryDto.fromJson(data['data'] as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load category: $e');
    }
  }

  @override
  Future<Category> createCategory(Category category) async {
    try {
      final dto = CategoryDto.fromDomain(category);
      
      final response = await apiClient.dio.post(
        ApiEndpoint.categories,
        data: dto.toJson(),
      );
      
      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;
        return CategoryDto.fromJson(data['data'] as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to create category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }

  @override
  Future<Category> updateCategory(String id, Category category) async {
    try {
      final dto = CategoryDto.fromDomain(category);
      
      final response = await apiClient.dio.put(
        '${ApiEndpoint.categories}/$id',
        data: dto.toJson(),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return CategoryDto.fromJson(data['data'] as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to update category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      final response = await apiClient.dio.delete('${ApiEndpoint.categories}/$id');
      
      if (response.statusCode != 200) {
        throw Exception('Failed to delete category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete category: $e');
    }
  }
}