enum TransactionDirectionEnum {
  inflow,
  outflow,
}

extension TransactionDirectionEnumExtension on TransactionDirectionEnum {
  String get value {
    switch (this) {
      case TransactionDirectionEnum.inflow:
        return 'in';
      case TransactionDirectionEnum.outflow:
        return 'out';
    }
  }
  
  String get displayName {
    switch (this) {
      case TransactionDirectionEnum.inflow:
        return 'In';
      case TransactionDirectionEnum.outflow:
        return 'Out';
    }
  }
  
  static TransactionDirectionEnum fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'in':
        return TransactionDirectionEnum.inflow;
      case 'out':
        return TransactionDirectionEnum.outflow;
      default:
        return TransactionDirectionEnum.outflow;
    }
  }
}