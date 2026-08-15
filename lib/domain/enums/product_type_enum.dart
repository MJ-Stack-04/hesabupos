
enum ProductTypeEnum {
  product,
  service,
}

extension ProductTypeEnumExtension on ProductTypeEnum {
  String get value {
    switch (this) {
      case ProductTypeEnum.product:
        return 'Product';
      case ProductTypeEnum.service:
        return 'Service';
    }
  }

  String get displayName {
    switch (this) {
      case ProductTypeEnum.product:
        return 'Product';
      case ProductTypeEnum.service:
        return 'Service';
    }
  }

  static ProductTypeEnum fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'product':
        return ProductTypeEnum.product;
      case 'service':
        return ProductTypeEnum.service;
      default:
        return ProductTypeEnum.product;
    }
  }

  static List<ProductTypeEnum> get valuesList => ProductTypeEnum.values;
  static List<String> get displayNames => ProductTypeEnum.values.map((e) => e.displayName).toList();
}