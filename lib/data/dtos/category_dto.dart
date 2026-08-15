
import 'package:hesabuapp/domain/entities/category.dart';
import 'package:hesabuapp/domain/enums/category_type_enum.dart';

class CategoryDto {
  final String id;
  final String name;
  final String type;

  CategoryDto({
    required this.id,
    required this.name,
    required this.type,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  Category toDomain() {
    return Category(
      id: id,
      name: name,
      type: CategoryTypeEnumExtension.fromValue(type),
    );
  }

  factory CategoryDto.fromDomain(Category category) {
    return CategoryDto(
      id: category.id,
      name: category.name,
      type: category.type.value,
    );
  }
}

class CreateCategoryDto {
  final String name;
  final String type;

  CreateCategoryDto({
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
}

class UpdateCategoryDto {
  final String? name;
  final String? type;

  UpdateCategoryDto({
    this.name,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (type != null) 'type': type,
    };
  }
}