
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/sale.dart';
import 'package:hesabuapp/domain/repositories/sale_repository.dart';

class SalesController extends GetxController {
  final SaleRepository saleRepository = Get.find();
  final UserService userService = Get.find();

  final sales = <Sale>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final searchQuery = ''.obs;
  final hasMoreData = true.obs;

  late Worker _branchWorker;

  @override
  void onInit() {
    super.onInit();
    _branchWorker = ever(userService.branchId, (branchId) {
      if (branchId.isNotEmpty) {
        sales.clear();
        error.value = '';
        loadSales();
      }
    });
    if (userService.branchId.value.isNotEmpty) {
      loadSales();
    }
  }

  @override
  void onClose() {
    _branchWorker.dispose();
    super.onClose();
  }

  void setSearch(String query) {
    searchQuery.value = query;
    loadSales();
  }

  void clearSearch() {
    searchQuery.value = '';
    loadSales();
  }

  Future<void> loadSales() async {
    if (userService.branchId.value.isEmpty) {
      error.value = 'Please select a branch first.';
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final result = await saleRepository.getSales();
      sales.value = result;
      hasMoreData.value = result.length >= 10;
    } catch (e) {
      error.value = 'Failed to load sales. Please try again.';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshSales() async {
    await loadSales();
  }

  Future<void> loadMore() async {
    if (!hasMoreData.value || isLoading.value) return;
  }
}