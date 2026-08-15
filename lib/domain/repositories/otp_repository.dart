
abstract class OtpRepository {
  Future<void> sendOtp(String email);
  Future<bool> verifyOtp(String code, String email);
}