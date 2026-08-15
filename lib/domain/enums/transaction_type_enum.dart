enum TransactionTypeEnum {
  sale,
  purchase,
  expense,
  refund,
  adjustment,
}

extension TransactionTypeEnumExtension on TransactionTypeEnum {
  String get displayName {
    switch (this) {
      case TransactionTypeEnum.sale:
        return 'Sale';
      case TransactionTypeEnum.purchase:
        return 'Purchase';
      case TransactionTypeEnum.expense:
        return 'Expense';
      case TransactionTypeEnum.refund:
        return 'Refund';
      case TransactionTypeEnum.adjustment:
        return 'Adjustment';
    }
  }
  
  String get value {
    switch (this) {
      case TransactionTypeEnum.sale:
        return 'SALE';
      case TransactionTypeEnum.purchase:
        return 'PURCHASE';
      case TransactionTypeEnum.expense:
        return 'EXPENSE';
      case TransactionTypeEnum.refund:
        return 'REFUND';
      case TransactionTypeEnum.adjustment:
        return 'ADJUSTMENT';
    }
  }
  
  static TransactionTypeEnum fromValue(String value) {
    switch (value.toUpperCase()) {
      case 'SALE':
        return TransactionTypeEnum.sale;
      case 'PURCHASE':
        return TransactionTypeEnum.purchase;
      case 'EXPENSE':
        return TransactionTypeEnum.expense;
      case 'REFUND':
        return TransactionTypeEnum.refund;
      case 'ADJUSTMENT':
        return TransactionTypeEnum.adjustment;
      default:
        return TransactionTypeEnum.expense;
    }
  }
}