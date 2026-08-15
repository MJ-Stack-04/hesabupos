import 'package:hesabuapp/domain/entities/inventory.dart';

class InventoryDto {
  final String? id;
  final String? productId;
  final int? quantityInStock;
  final DateTime? updatedAt;

  const InventoryDto({
    this.id,
    this.productId,
    this.quantityInStock,
    this.updatedAt,
  });

  factory InventoryDto.fromJson(Map<String, dynamic> json) {
    return InventoryDto(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      quantityInStock: _toInt(json['quantityInStock']),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (productId != null) 'productId': productId,
      if (quantityInStock != null) 'quantityInStock': quantityInStock.toString(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Inventory toDomain() {
    return Inventory(
      id: id ?? '',
      productId: productId ?? '',
      quantityInStock: quantityInStock ?? 0,
      updatedAt: updatedAt,
    );
  }

  factory InventoryDto.fromDomain(Inventory inventory) {
    return InventoryDto(
      id: inventory.id,
      productId: inventory.productId,
      quantityInStock: inventory.quantityInStock,
      updatedAt: inventory.updatedAt,
    );
  }

  static int? _toIntNullable(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static int _toInt(dynamic value) {
    return _toIntNullable(value) ?? 0;
  }
}