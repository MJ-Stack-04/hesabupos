
import 'package:hesabuapp/domain/entities/business.dart';

class BusinessDto {
  final String id;
  final String name;
  final String? industry;

  BusinessDto({
    required this.id,
    required this.name,
    this.industry,
  });

  factory BusinessDto.fromJson(Map<String, dynamic> json) {
    return BusinessDto(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      industry: json['industry'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (industry != null) 'industry': industry,
    };
  }

  Business toDomain() {
    return Business(
      id: id,
      name: name,
      industry: industry,
    );
  }

  factory BusinessDto.fromDomain(Business business) {
    return BusinessDto(
      id: business.id,
      name: business.name,
      industry: business.industry,
    );
  }
}

class CreateBusinessDto {
  final String name;
  final String? industry;

  CreateBusinessDto({
    required this.name,
    this.industry,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (industry != null) 'industry': industry,
    };
  }
}

class UpdateBusinessDto {
  final String? name;
  final String? industry;

  UpdateBusinessDto({
    this.name,
    this.industry,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (industry != null) 'industry': industry,
    };
  }
}