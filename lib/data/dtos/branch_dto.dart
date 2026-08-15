
import 'package:hesabuapp/domain/entities/branch.dart';

class BranchDto {
  final String id;
  final String name;
  final String? location;
  final String? description;
  final bool? isActive;

  BranchDto({
    required this.id,
    required this.name,
    this.location,
    this.description,
    this.isActive,
  });

  factory BranchDto.fromJson(Map<String, dynamic> json) {
    return BranchDto(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      location: json['location'] as String?,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (isActive != null) 'isActive': isActive,
    };
  }

  Branch toDomain() {
    return Branch(
      id: id,
      name: name,
      location: location,
      description: description,
      isActive: isActive,
    );
  }

  factory BranchDto.fromDomain(Branch branch) {
    return BranchDto(
      id: branch.id,
      name: branch.name,
      location: branch.location,
      description: branch.description,
      isActive: branch.isActive,
    );
  }
}

class CreateBranchDto {
  final String name;
  final String? location;
  final String? description;

  CreateBranchDto({
    required this.name,
    this.location,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
    };
  }
}

class UpdateBranchDto {
  final String? name;
  final String? location;
  final String? description;
  final bool? isActive;

  UpdateBranchDto({
    this.name,
    this.location,
    this.description,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (isActive != null) 'isActive': isActive,
    };
  }
}