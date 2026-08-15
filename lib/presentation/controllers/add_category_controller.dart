
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/domain/entities/category.dart';
import 'package:hesabuapp/domain/enums/category_type_enum.dart';
import 'package:hesabuapp/domain/repositories/category_repository.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:dio/dio.dart';

class AddCategoryController extends GetxController {
  final CategoryRepository categoryRepository = Get.find();
  final UserService userService = Get.find();

  final name = ''.obs;
  final type = CategoryTypeEnum.income.obs;
  final isLoading = false.obs;
  final nameError = ''.obs;
  final typeError = ''.obs;
  final generalError = ''.obs;

  List<CategoryTypeEnum> get typeOptions => CategoryTypeEnum.values;

  void setName(String value) {
    name.value = value;
    nameError.value = '';
  }

  void setType(CategoryTypeEnum value) {
    type.value = value;
    typeError.value = '';
  }

  bool validate() {
    nameError.value = '';
    typeError.value = '';
    generalError.value = '';

    if (userService.branchId.value.isEmpty) {
      generalError.value = 'No branch selected. Please wait for branch to load.';
      return false;
    }

    if (name.value.trim().isEmpty) {
      nameError.value = 'Category name is required';
      return false;
    }

    return true;
  }

  String _getUserFriendlyMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return 'Connection timeout. Please check your internet connection.';
        case DioExceptionType.connectionError:
          return 'No internet connection. Please check your network.';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 500) {
            return 'Sorry, we\'re having a technical issue. Please try again later.';
          }
          if (statusCode == 401) {
            return 'Your session has expired. Please login again.';
          }
          if (statusCode == 400) {
            final data = error.response?.data;
            if (data is Map && data.containsKey('message')) {
              return data['message'] as String;
            }
            return 'Invalid data. Please check your input.';
          }
          return 'Something went wrong. Please try again.';
        default:
          return 'Something went wrong. Please try again.';
      }
    }
    return 'Something went wrong. Please try again.';
  }

  Future<bool> saveCategory() async {
    if (!validate()) return false;

    isLoading.value = true;

    try {
      final category = Category(
        id: '',
        name: name.value.trim(),
        type: type.value,
      );

      final created = await categoryRepository.createCategory(category);

      Get.snackbar(
        'Success',
        'Category "${created.name}" created successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      _resetForm();
      Get.back(result: true);

      return true;
    } catch (e) {
      final userFriendlyMessage = _getUserFriendlyMessage(e);
      generalError.value = userFriendlyMessage;

      Get.snackbar(
        'Error',
        userFriendlyMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  void _resetForm() {
    name.value = '';
    type.value = CategoryTypeEnum.income;
    nameError.value = '';
    typeError.value = '';
    generalError.value = '';
  }

  void cancel() {
    Get.back();
  }
}