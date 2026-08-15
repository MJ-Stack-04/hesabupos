
import 'package:hesabuapp/domain/enums/payment_status_enum.dart';
import 'package:hesabuapp/domain/enums/product_type_enum.dart';
import 'category.dart';

class Product {
  final String id;
  final String? parentId;
  final String? sku;
  final double buyingPrice;
  final double sellingPrice;
  final double? maxPrice;
  final double? discount;
  final String title;
  final String? description;
  final ProductTypeEnum type;
  final bool isParent;
  final String? categoryId;
  final Category? category;
  final int? quantity;

  Product({
    required this.id,
    this.parentId,
    this.sku,
    required this.buyingPrice,
    required this.sellingPrice,
    this.maxPrice,
    this.discount,
    required this.title,
    this.description,
    required this.type,
    this.isParent = false,
    this.categoryId,
    this.category,
    this.quantity,
  });

  bool get isProduct => type == ProductTypeEnum.product;
  bool get isService => type == ProductTypeEnum.service;
  String get typeDisplay => type.displayName;
  String get typeValue => type.value;
  String get categoryName => category?.name ?? 'Uncategorized';

  Product copyWith({
    String? id,
    String? parentId,
    String? sku,
    double? buyingPrice,
    double? sellingPrice,
    double? maxPrice,
    double? discount,
    String? title,
    String? description,
    ProductTypeEnum? type,
    bool? isParent,
    String? categoryId,
    Category? category,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      sku: sku ?? this.sku,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      discount: discount ?? this.discount,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      isParent: isParent ?? this.isParent,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }
}