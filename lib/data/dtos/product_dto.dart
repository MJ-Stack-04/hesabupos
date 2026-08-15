
import 'package:hesabuapp/data/dtos/category_dto.dart';
import 'package:hesabuapp/domain/entities/product.dart';
import 'package:hesabuapp/domain/entities/category.dart';
import 'package:hesabuapp/domain/enums/payment_status_enum.dart';
import 'package:hesabuapp/domain/enums/product_type_enum.dart';

class ProductDto {
  final String? id;
  final String? parentId;
  final String? sku;
  final double? buyingPrice;
  final double? sellingPrice;
  final double? maxPrice;
  final Map<String, dynamic>? discount;
  final String? title;
  final String? description;
  final String? type;
  final bool? isParent;
  final String? categoryId;
  final Map<String, dynamic>? quantity;
  final Map<String, dynamic>? category;

  const ProductDto({
    this.id,
    this.parentId,
    this.sku,
    this.buyingPrice,
    this.sellingPrice,
    this.maxPrice,
    this.discount,
    this.title,
    this.description,
    this.type,
    this.isParent,
    this.categoryId,
    this.quantity,
    this.category,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as String?,
      parentId: json['parentId'] as String?,
      sku: json['sku'] as String?,
      buyingPrice: _toDouble(json['buyingPrice']),
      sellingPrice: _toDouble(json['sellingPrice']),
      maxPrice: _toDoubleNullable(json['maxPrice']),
      discount: json['discount'] as Map<String, dynamic>?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      isParent: json['isParent'] as bool?,
      categoryId: json['categoryId'] as String?,
      quantity: json['quantity'] as Map<String, dynamic>?,
      category: json['category'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (parentId != null) 'parentId': parentId,
      if (sku != null) 'sku': sku,
      if (buyingPrice != null) 'buyingPrice': buyingPrice.toString(),
      if (sellingPrice != null) 'sellingPrice': sellingPrice.toString(),
      if (maxPrice != null) 'maxPrice': maxPrice.toString(),
      if (discount != null && discount!.isNotEmpty) 'discount': discount,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (categoryId != null) 'categoryId': categoryId,
      if (quantity != null && quantity!.isNotEmpty) 'quantity': quantity,
    };
  }

  Product toDomain() {
    return Product(
      id: id ?? '',
      parentId: parentId,
      sku: sku,
      buyingPrice: buyingPrice ?? 0.0,
      sellingPrice: sellingPrice ?? 0.0,
      maxPrice: maxPrice,
      discount: null,
      title: title ?? '',
      description: description,
      type: type != null ? ProductTypeEnumExtension.fromValue(type!) : ProductTypeEnum.product,
      isParent: isParent ?? false,
      categoryId: categoryId,
      category: category != null ? CategoryDto.fromJson(category!).toDomain() : null,
      quantity: quantity != null ? _parseQuantity(quantity!) : null,
    );
  }

  factory ProductDto.fromDomain(Product product) {
    return ProductDto(
      id: product.id,
      parentId: product.parentId,
      sku: product.sku,
      buyingPrice: product.buyingPrice,
      sellingPrice: product.sellingPrice,
      maxPrice: product.maxPrice,
      discount: product.discount != null ? {'value': product.discount} : null,
      title: product.title,
      description: product.description,
      type: product.type.value,
      isParent: product.isParent,
      categoryId: product.categoryId,
      quantity: product.quantity != null ? {'inStock': product.quantity} : null,
    );
  }

  static int? _parseQuantity(Map<String, dynamic> quantity) {
    if (quantity.containsKey('inStock')) {
      return quantity['inStock'] as int?;
    }
    return null;
  }

  static double? _toDoubleNullable(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static double _toDouble(dynamic value) {
    return _toDoubleNullable(value) ?? 0.0;
  }
}