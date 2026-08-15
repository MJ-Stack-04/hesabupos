import 'package:dio/dio.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/dtos/transaction_dto.dart';
import 'package:hesabuapp/data/services/api_endpoints.dart';
import 'package:hesabuapp/domain/entities/transaction.dart';
import 'package:hesabuapp/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final ApiClient apiClient;

  TransactionRepositoryImpl(this.apiClient);

  @override
  Future<List<Transaction>> getTransactions({
    String? type,
    String? direction,
    String? search,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final Map<String, dynamic> query = {
        'page': page,
        'limit': limit,
      };
      
      if (type != null && type != 'all') {
        query['type'] = type.toUpperCase();
      }
      
      if (direction != null) {
        query['direction'] = direction;
      }
      
      if (search != null && search.isNotEmpty) {
        query['search'] = search;
      }

      final response = await apiClient.dio.get(
        ApiEndpoint.transactions,
        queryParameters: query,
      );

      final List<dynamic> data = response.data['data'] ?? [];

      return data.map((json) {
        final dto = TransactionDto.fromJson(json);
        return Transaction(
          id: dto.id,
          categoryId: dto.categoryId,
          type: dto.type,
          amount: dto.amount,
          direction: dto.direction,
          reference: dto.reference,
          description: dto.description,
        );
      }).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load transactions: ${e.message}');
    }
  }

  @override
  Future<Transaction> getTransaction(String transactionId) async {
    try {
      final response = await apiClient.dio.get(
        '${ApiEndpoint.transactions}/$transactionId',
      );

      final dto = TransactionDto.fromJson(response.data['data']);

      return Transaction(
        id: dto.id,
        categoryId: dto.categoryId,
        type: dto.type,
        amount: dto.amount,
        direction: dto.direction,
        reference: dto.reference,
        description: dto.description,
      );
    } on DioException catch (e) {
      throw Exception('Failed to load transaction: ${e.message}');
    }
  }

  @override
  Future<Transaction> createTransaction({
    required String categoryId,
    required String type,
    required double amount,
    required String direction,
    required String reference,
    required String description,
  }) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoint.transactions,
        data: {
          'categoryId': categoryId,
          'type': type,
          'amount': amount.toString(),
          'direction': direction,
          'reference': reference,
          'description': description,
        },
      );

      final dto = TransactionDto.fromJson(response.data['data']);

      return Transaction(
        id: dto.id,
        categoryId: dto.categoryId,
        type: dto.type,
        amount: dto.amount,
        direction: dto.direction,
        reference: dto.reference,
        description: dto.description,
      );
    } on DioException catch (e) {
      throw Exception('Failed to create transaction: ${e.message}');
    }
  }

  @override
  Future<Transaction> updateTransaction({
    required String transactionId,
    required String categoryId,
    required String type,
    required double amount,
    required String direction,
    required String reference,
    required String description,
  }) async {
    try {
      final response = await apiClient.dio.put(
        '${ApiEndpoint.transactions}/$transactionId',
        data: {
          'categoryId': categoryId,
          'type': type,
          'amount': amount.toString(),
          'direction': direction,
          'reference': reference,
          'description': description,
        },
      );

      final dto = TransactionDto.fromJson(response.data['data']);

      return Transaction(
        id: dto.id,
        categoryId: dto.categoryId,
        type: dto.type,
        amount: dto.amount,
        direction: dto.direction,
        reference: dto.reference,
        description: dto.description,
      );
    } on DioException catch (e) {
      throw Exception('Failed to update transaction: ${e.message}');
    }
  }

  @override
  Future<void> reverseTransaction(String transactionId) async {
    try {
      await apiClient.dio.put(
        '${ApiEndpoint.transactions}/$transactionId/reverse',
      );
    } on DioException catch (e) {
      throw Exception('Failed to reverse transaction: ${e.message}');
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      await apiClient.dio.delete(
        '${ApiEndpoint.transactions}/$transactionId',
      );
    } on DioException catch (e) {
      throw Exception('Failed to delete transaction: ${e.message}');
    }
  }
}