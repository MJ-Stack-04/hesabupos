
import 'package:flutter/material.dart';

enum CategoryTypeEnum {
  income,
  expense,
}

extension CategoryTypeEnumExtension on CategoryTypeEnum {
  String get value {
    switch (this) {
      case CategoryTypeEnum.income:
        return 'income';
      case CategoryTypeEnum.expense:
        return 'expense';
    }
  }

  String get displayName {
    switch (this) {
      case CategoryTypeEnum.income:
        return 'Income';
      case CategoryTypeEnum.expense:
        return 'Expense';
    }
  }

  IconData get icon {
    switch (this) {
      case CategoryTypeEnum.income:
        return Icons.arrow_upward;
      case CategoryTypeEnum.expense:
        return Icons.arrow_downward;
    }
  }

  Color get color {
    switch (this) {
      case CategoryTypeEnum.income:
        return Colors.green;
      case CategoryTypeEnum.expense:
        return Colors.red;
    }
  }

  static CategoryTypeEnum fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'income':
        return CategoryTypeEnum.income;
      case 'expense':
        return CategoryTypeEnum.expense;
      default:
        return CategoryTypeEnum.income;
    }
  }

  static List<CategoryTypeEnum> get valuesList => CategoryTypeEnum.values;
  static List<String> get displayNames => CategoryTypeEnum.values.map((e) => e.displayName).toList();
}