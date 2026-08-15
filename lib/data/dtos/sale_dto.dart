
import 'package:hesabuapp/domain/entities/sale_item.dart';
import 'package:hesabuapp/domain/enums/payment_method_enum.dart';
import 'package:hesabuapp/domain/enums/payment_status_enum.dart';

class Sale {
  final String id;
  final String? invoiceNumber;
  final PaymentMethodEnum? paymentMethod;
  final PaymentStatusEnum? paymentStatus;
  final double totalAmount;
  final String? description;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final List<SaleItem>? items;

  Sale({
    required this.id,
    this.invoiceNumber,
    this.paymentMethod,
    this.paymentStatus,
    required this.totalAmount,
    this.description,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  Sale copyWith({
    String? id,
    String? invoiceNumber,
    PaymentMethodEnum? paymentMethod,
    PaymentStatusEnum? paymentStatus,
    double? totalAmount,
    String? description,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
    List<SaleItem>? items,
  }) {
    return Sale(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      totalAmount: totalAmount ?? this.totalAmount,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }
}