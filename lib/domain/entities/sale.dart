
import 'package:hesabuapp/domain/enums/payment_method_enum.dart';
import 'package:hesabuapp/domain/enums/payment_status_enum.dart';

class Sale {
  final String id;
  final String? invoiceNumber;
  final double totalAmount;
  final String? description;
  final PaymentStatusEnum? paymentStatus;
  final PaymentMethodEnum? paymentMethod;
  final String? createdAt;
  final String? updatedAt;

  Sale({
    required this.id,
    this.invoiceNumber,
    required this.totalAmount,
    this.description,
    this.paymentStatus,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
  });

  Sale copyWith({
    String? id,
    String? invoiceNumber,
    double? totalAmount,
    String? description,
    PaymentStatusEnum? paymentStatus,
    PaymentMethodEnum? paymentMethod,
    String? createdAt,
    String? updatedAt,
  }) {
    return Sale(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      totalAmount: totalAmount ?? this.totalAmount,
      description: description ?? this.description,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}