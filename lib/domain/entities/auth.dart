
import 'user.dart';

class Auth {
  final String token;
  final String refreshToken;
  final User user;

  Auth({
    required this.token,
    required this.refreshToken,
    required this.user,
  });

  Auth copyWith({
    String? token,
    String? refreshToken,
    User? user,
  }) {
    return Auth(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }
}