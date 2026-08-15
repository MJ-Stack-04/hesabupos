
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/transaction.dart';
import 'package:hesabuapp/domain/repositories/transaction_repository.dart';

class TransactionsController extends GetxController {
  final TransactionRepository transactionRepository = Get.find();
  final UserService userService = Get.find();

  final transactions = <Transaction>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final searchQuery = ''.obs;
  final selectedFilter = 'all'.obs;

  late Worker _branchWorker;

  @override
  void onInit() {
    super.onInit();

    _branchWorker = ever(userService.branchId, (branchId) {
      if (branchId.isNotEmpty) {
        transactions.clear();
        error.value = '';
        loadTransactions();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userService.branchId.value.isNotEmpty) {
        loadTransactions();
      }
    });
  }

  @override
  void onClose() {
    _branchWorker.dispose();
    super.onClose();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    loadTransactions();
  }

  void setSearch(String query) {
    searchQuery.value = query;
    loadTransactions();
  }

  void clearSearch() {
    searchQuery.value = '';
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    if (userService.branchId.value.isEmpty) {
      error.value = 'Please select a branch first.';
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final result = await transactionRepository.getTransactions();
      transactions.value = result;
    } catch (e) {
      error.value = 'Failed to load transactions. Please try again.';
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTransactions() async {
    await loadTransactions();
  }
}