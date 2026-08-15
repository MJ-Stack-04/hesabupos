import 'package:hesabuapp/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions({
    String? type,
    String? direction,
    String? search,
    int page = 1,
    int limit = 10,
  });
  
  Future<Transaction> getTransaction(String transactionId);
  
  Future<Transaction> createTransaction({
    required String categoryId,
    required String type,
    required double amount,
    required String direction,
    required String reference,
    required String description,
  });
  
  Future<Transaction> updateTransaction({
    required String transactionId,
    required String categoryId,
    required String type,
    required double amount,
    required String direction,
    required String reference,
    required String description,
  });
  
  Future<void> reverseTransaction(String transactionId);
  
  Future<void> deleteTransaction(String transactionId);
}