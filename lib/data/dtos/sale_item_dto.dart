class SaleItemDto {
  final String id;
  final String productId;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  SaleItemDto({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory SaleItemDto.fromJson(Map<String, dynamic> json) {
    return SaleItemDto(
      id: json['id']?.toString() ?? '',
      productId: json['productId']?.toString() ?? '',
      quantity: json['quantity'] is int ? json['quantity'] : (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: double.parse(json['unitPrice']?.toString() ?? '0'),
      totalPrice: double.parse(json['totalPrice']?.toString() ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity.toString(),
      'unitPrice': unitPrice.toString(),
    };
  }
}