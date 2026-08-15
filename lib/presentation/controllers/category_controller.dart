
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/category.dart';
import 'package:hesabuapp/domain/enums/category_type_enum.dart';
import 'package:hesabuapp/domain/repositories/category_repository.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class CategoryController extends GetxController {
  final CategoryRepository categoryRepository = Get.find();
  final UserService userService = Get.find();

  final categories = <Category>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final searchQuery = ''.obs;

  late Worker _branchWorker;

  @override
  void onInit() {
    super.onInit();

    _branchWorker = ever(userService.branchId, (branchId) {
      if (branchId.isNotEmpty) {
        categories.clear();
        error.value = '';
        loadCategories();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userService.branchId.value.isNotEmpty) {
        loadCategories();
      }
    });
  }

  @override
  void onClose() {
    _branchWorker.dispose();
    super.onClose();
  }

  Future<void> loadCategories() async {
    if (userService.branchId.value.isEmpty) {
      error.value = 'Please select a branch first.';
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final result = await categoryRepository.getCategories();
      categories.value = result;
    } catch (e) {
      error.value = 'Failed to load categories. Please try again.';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshCategories() async {
    await loadCategories();
  }

  void setSearch(String query) {
    searchQuery.value = query;
    loadCategories();
  }

  void clearSearch() {
    searchQuery.value = '';
    loadCategories();
  }

  Future<void> deleteCategory(String id) async {
    try {
      await categoryRepository.deleteCategory(id);
      categories.removeWhere((c) => c.id == id);
      Get.snackbar('Success', 'Category deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete category. Please try again.');
    }
  }

  void goToAddCategory() {
    Get.toNamed(AppRoutes.addCategory);
  }
}