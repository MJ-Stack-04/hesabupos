
import 'package:flutter/material.dart';

enum PaymentStatusEnum {
  pending,
  completed,
  cancelled,
  refunded,
}

extension PaymentStatusEnumExtension on PaymentStatusEnum {
  String get value {
    switch (this) {
      case PaymentStatusEnum.pending:
        return 'pending';
      case PaymentStatusEnum.completed:
        return 'completed';
      case PaymentStatusEnum.cancelled:
        return 'cancelled';
      case PaymentStatusEnum.refunded:
        return 'refunded';
    }
  }

  String get displayName {
    switch (this) {
      case PaymentStatusEnum.pending:
        return 'Pending';
      case PaymentStatusEnum.completed:
        return 'Completed';
      case PaymentStatusEnum.cancelled:
        return 'Cancelled';
      case PaymentStatusEnum.refunded:
        return 'Refunded';
    }
  }

  Color get color {
    switch (this) {
      case PaymentStatusEnum.pending:
        return Colors.orange;
      case PaymentStatusEnum.completed:
        return Colors.green;
      case PaymentStatusEnum.cancelled:
        return Colors.red;
      case PaymentStatusEnum.refunded:
        return Colors.purple;
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentStatusEnum.pending:
        return Icons.hourglass_empty;
      case PaymentStatusEnum.completed:
        return Icons.check_circle;
      case PaymentStatusEnum.cancelled:
        return Icons.cancel;
      case PaymentStatusEnum.refunded:
        return Icons.undo;
    }
  }

  static PaymentStatusEnum fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'pending':
        return PaymentStatusEnum.pending;
      case 'completed':
        return PaymentStatusEnum.completed;
      case 'cancelled':
        return PaymentStatusEnum.cancelled;
      case 'refunded':
        return PaymentStatusEnum.refunded;
      default:
        return PaymentStatusEnum.pending;
    }
  }

  static List<PaymentStatusEnum> get valuesList => PaymentStatusEnum.values;
  static List<String> get displayNames => PaymentStatusEnum.values.map((e) => e.displayName).toList();
}