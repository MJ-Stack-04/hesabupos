
import 'package:hesabuapp/data/dtos/user_dto.dart';
import 'package:hesabuapp/domain/entities/auth.dart';
import 'package:hesabuapp/domain/entities/user.dart';

class AuthDto {
  final bool success;
  final String message;
  final AuthDataDto? data;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? phone;

  AuthDto({
    this.success = false,
    this.message = '',
    this.data,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory AuthDto.fromRequest({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
    String? phone,
  }) {
    return AuthDto(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );
  }

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return AuthDto(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? AuthDataDto.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (phone != null) 'phone': phone,
    };
  }

  Auth toDomain() {
    if (data == null) {
      throw Exception('No data returned from server');
    }
    return Auth(
      token: data!.accessToken ?? '',
      refreshToken: data!.refreshToken ?? '',
      user: data!.user?.toDomain() ?? User(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        role: 'user',
      ),
    );
  }
}

class AuthDataDto {
  final String? accessToken;
  final String? refreshToken;
  final UserDto? user;

  AuthDataDto({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory AuthDataDto.fromJson(Map<String, dynamic> json) {
    return AuthDataDto(
      accessToken: json['accessToken'] ?? json['_token'] ?? json['token'],
      refreshToken: json['refreshToken'],
      user: json['user'] != null
          ? UserDto.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user?.toJson(),
    };
  }
}