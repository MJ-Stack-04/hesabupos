
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/product.dart';
import 'package:hesabuapp/domain/entities/category.dart';
import 'package:hesabuapp/domain/enums/payment_status_enum.dart';
import 'package:hesabuapp/domain/enums/product_type_enum.dart';
import 'package:hesabuapp/domain/repositories/product_repository.dart';
import 'package:hesabuapp/domain/repositories/category_repository.dart';
import 'package:dio/dio.dart';

class AddProductController extends GetxController {
  final ProductRepository productRepository = Get.find();
  final CategoryRepository categoryRepository = Get.find();
  final UserService userService = Get.find();

  final title = ''.obs;
  final type = ProductTypeEnum.product.obs;
  final description = ''.obs;
  final buyingPrice = 0.0.obs;
  final sellingPrice = 0.0.obs;
  final maxPrice = 0.0.obs;
  final quantity = 0.obs;
  final sku = ''.obs;
  final categoryId = ''.obs;
  final discount = ''.obs;

  final categories = <Category>[].obs;
  final isLoadingCategories = false.obs;
  final isLoading = false.obs;
  final errors = <String, String>{}.obs;

  List<ProductTypeEnum> get typeOptions => ProductTypeEnum.values;

  late Worker _branchWorker;

  @override
  void onInit() {
    super.onInit();
    _branchWorker = ever(userService.branchId, (_) {
      if (userService.branchId.value.isNotEmpty) {
        categories.clear();
        loadCategories();
      }
    });
    if (userService.branchId.value.isNotEmpty) {
      loadCategories();
    }
  }

  @override
  void onClose() {
    _branchWorker.dispose();
    super.onClose();
  }

  Future<void> loadCategories() async {
    if (userService.branchId.value.isEmpty) return;

    isLoadingCategories.value = true;
    try {
      final result = await categoryRepository.getCategories();
      categories.value = result;
    } catch (e) {
      // Silent fail
    } finally {
      isLoadingCategories.value = false;
    }
  }

  void setTitle(String value) {
    title.value = value;
    errors.remove('title');
  }

  void setType(ProductTypeEnum value) {
    type.value = value;
    errors.remove('type');
  }

  void setDescription(String value) {
    description.value = value;
  }

  void setBuyingPrice(String value) {
    buyingPrice.value = double.tryParse(value) ?? 0.0;
    errors.remove('buyingPrice');
  }

  void setSellingPrice(String value) {
    sellingPrice.value = double.tryParse(value) ?? 0.0;
    errors.remove('sellingPrice');
  }

  void setMaxPrice(String value) {
    maxPrice.value = double.tryParse(value) ?? 0.0;
  }

  void setQuantity(String value) {
    quantity.value = int.tryParse(value) ?? 0;
    errors.remove('quantity');
  }

  void setSku(String value) {
    sku.value = value;
  }

  void setCategoryId(String value) {
    categoryId.value = value;
    errors.remove('categoryId');
  }

  void setDiscount(String value) {
    discount.value = value;
  }

  bool validate() {
    errors.clear();
    bool isValid = true;

    if (title.value.trim().isEmpty) {
      errors['title'] = 'Product name is required';
      isValid = false;
    }

    if (categoryId.value.trim().isEmpty) {
      errors['categoryId'] = 'Please select a category';
      isValid = false;
    }

    if (buyingPrice.value <= 0) {
      errors['buyingPrice'] = 'Buying price must be greater than 0';
      isValid = false;
    }

    if (sellingPrice.value <= 0) {
      errors['sellingPrice'] = 'Selling price must be greater than 0';
      isValid = false;
    }

    if (sellingPrice.value < buyingPrice.value) {
      errors['sellingPrice'] = 'Selling price must be higher than buying price';
      isValid = false;
    }

    if (type.value == ProductTypeEnum.product && quantity.value < 0) {
      errors['quantity'] = 'Quantity cannot be negative';
      isValid = false;
    }

    return isValid;
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
          final data = error.response?.data;
          if (statusCode == 500) {
            return 'Sorry, we\'re having a technical issue. Please try again later.';
          }
          if (statusCode == 401) {
            return 'Your session has expired. Please login again.';
          }
          if (data is Map && data.containsKey('message')) {
            return data['message'] as String;
          }
          return 'Something went wrong. Please try again.';
        default:
          return 'Something went wrong. Please try again.';
      }
    }
    return 'Something went wrong. Please try again.';
  }

  Future<bool> saveProduct() async {
    if (!validate()) return false;

    isLoading.value = true;

    try {
      final product = Product(
        id: '',
        parentId: null,
        sku: sku.value.trim().isEmpty ? null : sku.value.trim(),
        buyingPrice: buyingPrice.value,
        sellingPrice: sellingPrice.value,
        maxPrice: maxPrice.value > 0 ? maxPrice.value : null,
        discount: discount.value.trim().isNotEmpty 
            ? double.tryParse(discount.value.trim()) 
            : null,
        title: title.value.trim(),
        description: description.value.trim().isEmpty ? null : description.value.trim(),
        type: type.value,
        isParent: false,
        categoryId: categoryId.value.trim().isEmpty ? null : categoryId.value.trim(),
        quantity: type.value == ProductTypeEnum.product ? quantity.value : null,
      );

      final created = await productRepository.createProduct(product);

      Get.snackbar(
        'Success',
        '${created.typeDisplay} "${created.title}" created successfully!',
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
      errors['general'] = userFriendlyMessage;
      
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
    title.value = '';
    type.value = ProductTypeEnum.product;
    description.value = '';
    buyingPrice.value = 0.0;
    sellingPrice.value = 0.0;
    maxPrice.value = 0.0;
    quantity.value = 0;
    sku.value = '';
    categoryId.value = '';
    discount.value = '';
    errors.clear();
  }

  void cancel() {
    Get.back();
  }
}