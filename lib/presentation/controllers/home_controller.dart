
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/entities/transaction.dart';
import 'package:hesabuapp/domain/entities/product.dart';
import 'package:hesabuapp/domain/enums/transaction_direction_enum.dart';
import 'package:hesabuapp/domain/repositories/branch_repository.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';
import 'package:hesabuapp/domain/repositories/transaction_repository.dart';
import 'package:hesabuapp/domain/repositories/product_repository.dart';

class HomeController extends GetxController {
  final BranchRepository branchRepository = Get.find();
  final AuthRepository authRepository = Get.find();
  final TransactionRepository transactionRepository = Get.find();
  final ProductRepository productRepository = Get.find();
  final UserService userService = Get.find();

  final userName = ''.obs;
  final branchName = ''.obs;
  final income = 0.0.obs;
  final revenue = 0.0.obs;
  final expenses = 0.0.obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final transactions = <Transaction>[].obs;
  final popularProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    userName.value = userService.firstName.value;
    _loadBranch();
  }

  Future<void> _loadBranch() async {
    try {
      final allBranches = await branchRepository.getBranches();
      final firstBranch = allBranches.first;
      await authRepository.switchBranch(firstBranch.id);

      final currentBranch = await branchRepository.getCurrentBranch();

      if (currentBranch.id.isNotEmpty) {
        userService.setBranch(
          branchId: currentBranch.id,
          branchName: currentBranch.name,
        );
        branchName.value = currentBranch.name;
      }
    } catch (e) {
      if (userService.branchId.value.isNotEmpty) {
        branchName.value = userService.branchName.value;
      }
    }

    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      isLoading.value = true;
      error.value = '';

      if (userService.branchId.value.isEmpty) {
        error.value = 'No branch selected.';
        isLoading.value = false;
        return;
      }

      await _loadTransactionsAndStats();

    } catch (e) {
      error.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Error', error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadTransactionsAndStats() async {
    try {
      final result = await transactionRepository.getTransactions();
      transactions.value = result;

      double totalIncome = 0;
      double totalExpenses = 0;

      for (var t in result) {
        if (t.direction == TransactionDirectionEnum.inflow) {
          totalIncome += t.amount;
        } else {
          totalExpenses += t.amount;
        }
      }

      income.value = totalIncome;
      revenue.value = totalIncome;
      expenses.value = totalExpenses;

      final products = await productRepository.getProducts();
      popularProducts.value = products.take(5).toList();

    } catch (e) {}
  }

  Future<void> refreshData() async {
    await _loadBranch();
  }
}