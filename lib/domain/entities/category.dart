
import 'package:hesabuapp/domain/enums/category_type_enum.dart';

class Category {
  final String id;
  final String name;
  final CategoryTypeEnum type;

  Category({
    required this.id,
    required this.name,
    required this.type,
  });

  String get typeValue => type.value;
  String get typeDisplay => type.displayName;

  Category copyWith({
    String? id,
    String? name,
    CategoryTypeEnum? type,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}