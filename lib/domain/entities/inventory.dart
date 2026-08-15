class Inventory {
  final String id;
  final String productId;
  final int quantityInStock;
  final DateTime? updatedAt;

  Inventory({
    required this.id,
    required this.productId,
    required this. quantityInStock,
    this.updatedAt,
  });
  Inventory copyWith({
    String? id,
    String? productId,
    int? quantityInStock,
    DateTime? updatedAt,
  }) {
    return Inventory(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantityInStock: quantityInStock ?? this.quantityInStock,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}