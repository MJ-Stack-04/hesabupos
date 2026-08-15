
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/product.dart';
import 'package:hesabuapp/domain/repositories/product_repository.dart';

class ProductsController extends GetxController {
  final ProductRepository productRepository = Get.find();
  final UserService userService = Get.find();

  final products = <Product>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final searchQuery = ''.obs;

  late Worker _branchWorker;

  @override
  void onInit() {
    super.onInit();

    _branchWorker = ever(userService.branchId, (branchId) {
      if (branchId.isNotEmpty) {
        products.clear();
        error.value = '';
        loadProducts();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userService.branchId.value.isNotEmpty) {
        loadProducts();
      }
    });
  }

  @override
  void onClose() {
    _branchWorker.dispose();
    super.onClose();
  }

  void setSearch(String query) {
    searchQuery.value = query;
    loadProducts();
  }

  void clearSearch() {
    searchQuery.value = '';
    loadProducts();
  }

  Future<void> loadProducts() async {
    if (userService.branchId.value.isEmpty) {
      error.value = 'Please select a branch first.';
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      List<Product> result;
      if (searchQuery.value.isNotEmpty) {
        result = await productRepository.searchProducts(searchQuery.value);
      } else {
        result = await productRepository.getProducts();
      }
      products.value = result;
    } catch (e) {
      error.value = 'Failed to load products. Please try again.';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await loadProducts();
  }

  Future<bool> deleteProduct(String id) async {
    try {
      isLoading.value = true;
      await productRepository.deleteProduct(id);
      products.removeWhere((p) => p.id == id);
      Get.snackbar('Success', 'Product deleted successfully');
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product. Please try again.');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}