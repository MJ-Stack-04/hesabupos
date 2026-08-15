
import 'package:hesabuapp/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  Future<Product> getProductBySku(String sku);
  Future<List<Product>> searchProducts(String query);
  Future<List<Product>> getProductsByType(String type);
  Future<List<Product>> getProductVariants(String productId);
  Future<Product> createProduct(Product product);
  Future<Product> updateProduct(String id, Product product);
  Future<void> deleteProduct(String id);
}