
abstract class ResetPasswordRepository {
  Future<void> requestReset(String email);
  Future<void> verifyResetOtp(String email, String otp);
  Future<void> confirmReset(String email, String otp, String newPassword);
}