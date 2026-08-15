import 'package:get/get.dart';
import 'package:hesabuapp/domain/repositories/reset_password_repository.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class ResetPasswordController extends GetxController {
  final ResetPasswordRepository resetPasswordRepository = Get.find();
  
  var otp = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;
  var isLoading = false.obs;
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;
  
  var otpError = ''.obs;
  var newPasswordError = ''.obs;
  var confirmPasswordError = ''.obs;
  var generalError = ''.obs;
  
  var email = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments ?? '';
  }
  
  void setOtp(String value) {
    otp.value = value;
    otpError.value = '';
  }
  
  void setNewPassword(String value) {
    newPassword.value = value;
    newPasswordError.value = '';
  }
  
  void setConfirmPassword(String value) {
    confirmPassword.value = value;
    confirmPasswordError.value = '';
  }
  
  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }
  
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.toggle();
  }
  
  Future<void> resetPassword() async {
    otpError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';
    generalError.value = '';
    
    if (otp.value.isEmpty) {
      otpError.value = 'OTP is required';
      return;
    }
    if (otp.value.length < 4) {
      otpError.value = 'Enter a valid OTP';
      return;
    }
    if (newPassword.value.isEmpty) {
      newPasswordError.value = 'New password is required';
      return;
    }
    if (newPassword.value.length < 6) {
      newPasswordError.value = 'Password must be at least 6 characters';
      return;
    }
    if (confirmPassword.value.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      return;
    }
    if (newPassword.value != confirmPassword.value) {
      confirmPasswordError.value = 'Passwords do not match';
      return;
    }
    
    isLoading.value = true;
    
    try {
      await resetPasswordRepository.verifyResetOtp(email.value, otp.value);
      
      await resetPasswordRepository.confirmReset(email.value, otp.value, newPassword.value);
      
      Get.snackbar('Success', 'Password reset successfully!');
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      generalError.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Error', generalError.value);
    } finally {
      isLoading.value = false;
    }
  }
}