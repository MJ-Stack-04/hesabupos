
import 'package:hesabuapp/domain/enums/transaction_direction_enum.dart';
import 'package:hesabuapp/domain/enums/transaction_type_enum.dart';

class Transaction {
  final String id;
  final String categoryId;
  final TransactionTypeEnum type;
  final double amount;
  final TransactionDirectionEnum direction;
  final String reference;
  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Transaction({
    required this.id,
    required this.categoryId,
    required this.type,
    required this.amount,
    required this.direction,
    required this.reference,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });
}