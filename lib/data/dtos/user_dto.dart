
import 'package:hesabuapp/domain/entities/user.dart';

class UserDto {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final String? onboardingStep;
  final String? status;
  final String? defaultBranchId;
  final String? defaultBranchName;
  final String? defaultBusinessId;
  final String? defaultBusinessName;

  UserDto({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.onboardingStep,
    this.status,
    this.defaultBranchId,
    this.defaultBranchName,
    this.defaultBusinessId,
    this.defaultBusinessName,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id']?.toString(),
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      role: json['role']?.toString(),
      onboardingStep: json['onboardingStep']?.toString(),
      status: json['status']?.toString(),
      defaultBranchId: json['defaultBranchId']?.toString(),
      defaultBranchName: json['defaultBranchName']?.toString(),
      defaultBusinessId: json['defaultBusinessId']?.toString(),
      defaultBusinessName: json['defaultBusinessName']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (onboardingStep != null) 'onboardingStep': onboardingStep,
      if (status != null) 'status': status,
      if (defaultBranchId != null) 'defaultBranchId': defaultBranchId,
      if (defaultBranchName != null) 'defaultBranchName': defaultBranchName,
      if (defaultBusinessId != null) 'defaultBusinessId': defaultBusinessId,
      if (defaultBusinessName != null) 'defaultBusinessName': defaultBusinessName,
    };
  }

  User toDomain() {
    return User(
      id: id ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      phone: phone,
      role: role ?? 'user',
      onboardingStep: onboardingStep,
      status: status,
      defaultBranchId: defaultBranchId,
      defaultBranchName: defaultBranchName,
      defaultBusinessId: defaultBusinessId,
      defaultBusinessName: defaultBusinessName,
    );
  }

  factory UserDto.fromDomain(User user) {
    return UserDto(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phone: user.phone,
      role: user.role,
      onboardingStep: user.onboardingStep,
      status: user.status,
      defaultBranchId: user.defaultBranchId,
      defaultBranchName: user.defaultBranchName,
      defaultBusinessId: user.defaultBusinessId,
      defaultBusinessName: user.defaultBusinessName,
    );
  }
}