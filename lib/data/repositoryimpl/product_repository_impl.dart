
import 'package:dio/dio.dart';
import 'package:hesabuapp/data/dtos/product_dto.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/domain/entities/product.dart';
import 'package:hesabuapp/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient apiClient;
  final SharedPreference sharedPreference;

  ProductRepositoryImpl(this.apiClient, this.sharedPreference);

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoint.products);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => ProductDto.fromJson(json as Map<String, dynamic>).toDomain())
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await apiClient.dio.get('${ApiEndpoint.products}/id/$id');
      
      if (response.statusCode == 200) {
        return ProductDto.fromJson(response.data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  @override
  Future<Product> getProductBySku(String sku) async {
    try {
      final response = await apiClient.dio.get('${ApiEndpoint.products}/sku/$sku');
      
      if (response.statusCode == 200) {
        return ProductDto.fromJson(response.data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to load product by SKU: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load product by SKU: $e');
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoint.productsSearch,
        queryParameters: {'query': query},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => ProductDto.fromJson(json as Map<String, dynamic>).toDomain())
            .toList();
      } else {
        throw Exception('Failed to search products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  @override
  Future<List<Product>> getProductsByType(String type) async {
    try {
      final response = await apiClient.dio.get('${ApiEndpoint.products}/type/$type');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => ProductDto.fromJson(json as Map<String, dynamic>).toDomain())
            .toList();
      } else {
        throw Exception('Failed to load products by type: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products by type: $e');
    }
  }

  @override
  Future<List<Product>> getProductVariants(String productId) async {
    try {
      final response = await apiClient.dio.get('${ApiEndpoint.products}/$productId/variants');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => ProductDto.fromJson(json as Map<String, dynamic>).toDomain())
            .toList();
      } else {
        throw Exception('Failed to load product variants: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load product variants: $e');
    }
  }

  @override
  Future<Product> createProduct(Product product) async {
    try {
      final dto = ProductDto.fromDomain(product);
      
      final response = await apiClient.dio.post(
        ApiEndpoint.products,
        data: dto.toJson(),
      );
      
      if (response.statusCode == 201) {
        return ProductDto.fromJson(response.data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to create product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  @override
  Future<Product> updateProduct(String id, Product product) async {
    try {
      final dto = ProductDto.fromDomain(product);
      
      final response = await apiClient.dio.put(
        '${ApiEndpoint.products}/$id',
        data: dto.toJson(),
      );
      
      if (response.statusCode == 200) {
        return ProductDto.fromJson(response.data as Map<String, dynamic>).toDomain();
      } else {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final response = await apiClient.dio.delete('${ApiEndpoint.products}/$id');
      
      if (response.statusCode != 204) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}