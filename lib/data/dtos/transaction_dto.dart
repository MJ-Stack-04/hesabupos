
import 'package:hesabuapp/domain/enums/transaction_direction_enum.dart';
import 'package:hesabuapp/domain/enums/transaction_type_enum.dart';

class TransactionDto {
  final String id;
  final String categoryId;
  final TransactionTypeEnum type;
  final double amount;
  final TransactionDirectionEnum direction;
  final String reference;
  final String description;
  final String? createdAt;
  final String? updatedAt;

  TransactionDto({
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

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      id: json['id']?.toString() ?? '',
      categoryId: json['categoryId']?.toString() ?? '',
      type: TransactionTypeEnumExtension.fromValue(json['type'] ?? 'EXPENSE'),
      amount: double.parse(json['amount']?.toString() ?? '0'),
      direction: TransactionDirectionEnumExtension.fromValue(json['direction'] ?? 'out'),
      reference: json['reference'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'type': type.value,
      'amount': amount.toString(),
      'direction': direction.value,
      'reference': reference,
      'description': description,
    };
  }
}