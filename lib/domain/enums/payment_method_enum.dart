enum PaymentMethodEnum {
  cash,
  mpesa,
  card,
  bank,
  other,
}

extension PaymentMethodEnumExtension on PaymentMethodEnum {
  String get value {
    switch (this) {
      case PaymentMethodEnum.cash:
        return 'cash';
      case PaymentMethodEnum.mpesa:
        return 'mpesa';
      case PaymentMethodEnum.card:
        return 'card';
      case PaymentMethodEnum.bank:
        return 'bank';
      case PaymentMethodEnum.other:
        return 'other';
    }
  }
  
  String get displayName {
    switch (this) {
      case PaymentMethodEnum.cash:
        return 'Cash';
      case PaymentMethodEnum.mpesa:
        return 'M-Pesa';
      case PaymentMethodEnum.card:
        return 'Card';
      case PaymentMethodEnum.bank:
        return 'Bank Transfer';
      case PaymentMethodEnum.other:
        return 'Other';
    }
  }
  
  static PaymentMethodEnum fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'cash':
        return PaymentMethodEnum.cash;
      case 'mpesa':
        return PaymentMethodEnum.mpesa;
      case 'card':
        return PaymentMethodEnum.card;
      case 'bank':
        return PaymentMethodEnum.bank;
      default:
        return PaymentMethodEnum.other;
    }
  }
}