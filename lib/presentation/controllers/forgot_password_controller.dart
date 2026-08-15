import 'package:get/get.dart';
import 'package:hesabuapp/domain/repositories/reset_password_repository.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  final ResetPasswordRepository resetPasswordRepository = Get.find();
  
  var email = ''.obs;
  var isLoading = false.obs;
  var emailError = ''.obs;
  var generalError = ''.obs;
  
  void setEmail(String value) {
    email.value = value;
    emailError.value = '';
  }
  
  Future<void> requestReset() async {
    emailError.value = '';
    generalError.value = '';
    
    if (email.value.isEmpty) {
      emailError.value = 'Email is required';
      return;
    }
    if (!GetUtils.isEmail(email.value)) {
      emailError.value = 'Enter a valid email';
      return;
    }
    
    isLoading.value = true;
    
    try {
      await resetPasswordRepository.requestReset(email.value);
      Get.snackbar('Success', 'Check your email for OTP');
      Get.toNamed(AppRoutes.resetPassword, arguments: email.value);
    } catch (e) {
      generalError.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Error', generalError.value);
    } finally {
      isLoading.value = false;
    }
  }
}