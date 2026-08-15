
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/domain/entities/transaction.dart';
import 'package:hesabuapp/domain/enums/transaction_direction_enum.dart';
import 'package:hesabuapp/domain/enums/transaction_type_enum.dart';
import 'package:hesabuapp/presentation/controllers/transaction_controller.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionsController controller = Get.put(TransactionsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildFilterTabs(controller),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(controller),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.transactions.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error.value.isNotEmpty) {
                return _buildErrorState(controller);
              }

              if (controller.transactions.isEmpty) {
                return _buildEmptyState();
              }

              return RefreshIndicator(
                onRefresh: controller.refreshTransactions,
                child: ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.transactions[index];
                    return _buildTransactionItem(transaction);
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar('Coming Soon', 'Add transaction feature coming soon');
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFilterTabs(TransactionsController controller) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() => ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterTab(controller, 'all', 'All'),
          const SizedBox(width: 8),
          _buildFilterTab(controller, 'SALE', 'Sales'),
          const SizedBox(width: 8),
          _buildFilterTab(controller, 'PURCHASE', 'Purchases'),
          const SizedBox(width: 8),
          _buildFilterTab(controller, 'EXPENSE', 'Expenses'),
          const SizedBox(width: 8),
          _buildFilterTab(controller, 'REFUND', 'Refunds'),
          const SizedBox(width: 8),
          _buildFilterTab(controller, 'ADJUSTMENT', 'Adjustments'),
        ],
      )),
    );
  }

  Widget _buildFilterTab(TransactionsController controller, String filter, String label) {
    return FilterChip(
      label: Text(label),
      selected: controller.selectedFilter.value == filter,
      onSelected: (_) => controller.setFilter(filter),
      backgroundColor: Colors.grey.shade100,
      selectedColor: Theme.of(Get.context!).primaryColor.withOpacity(0.2),
      checkmarkColor: Theme.of(Get.context!).primaryColor,
    );
  }

  Widget _buildSearchBar(TransactionsController controller) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Obx(() => TextField(
        onChanged: controller.setSearch,
        decoration: InputDecoration(
          hintText: 'Search transactions...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: controller.clearSearch,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(Get.context!).primaryColor),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      )),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first transaction',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(TransactionsController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.error.value,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: controller.refreshTransactions,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    final color = _getTransactionColor(transaction.type);
    final icon = _getTransactionIcon(transaction.type);
    final directionColor = transaction.direction == TransactionDirectionEnum.inflow 
        ? Colors.green 
        : Colors.red;
    final directionIcon = transaction.direction == TransactionDirectionEnum.inflow 
        ? Icons.arrow_downward 
        : Icons.arrow_upward;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          transaction.description,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ref: ${transaction.reference}',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Text(
              '${transaction.type.displayName} • ${transaction.direction.displayName}',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              directionIcon,
              color: directionColor,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              'KES ${transaction.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: directionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTransactionColor(TransactionTypeEnum type) {
    switch (type) {
      case TransactionTypeEnum.sale:
        return Colors.green;
      case TransactionTypeEnum.purchase:
        return Colors.orange;
      case TransactionTypeEnum.expense:
        return Colors.red;
      case TransactionTypeEnum.refund:
        return Colors.purple;
      case TransactionTypeEnum.adjustment:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getTransactionIcon(TransactionTypeEnum type) {
    switch (type) {
      case TransactionTypeEnum.sale:
        return Icons.shopping_cart_outlined;
      case TransactionTypeEnum.purchase:
        return Icons.shopping_bag_outlined;
      case TransactionTypeEnum.expense:
        return Icons.money_off_outlined;
      case TransactionTypeEnum.refund:
        return Icons.undo_outlined;
      case TransactionTypeEnum.adjustment:
        return Icons.tune_outlined;
      default:
        return Icons.receipt_outlined;
    }
  }
}