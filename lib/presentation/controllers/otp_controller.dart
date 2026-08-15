import 'package:get/get.dart';
import 'package:hesabuapp/domain/repositories/otp_repository.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class OtpController extends GetxController {
  final OtpRepository otpRepository = Get.find();
  
  var isSendingOtp = false.obs;
  var isVerifyingOtp = false.obs;
  var otpCode = ''.obs;
  var otpError = ''.obs;
  var email = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments ?? '';
    if (email.value.isNotEmpty) {
      sendOtp();
    }
  }
  
  void setOtpCode(String value) {
    otpCode.value = value;
    otpError.value = '';
  }
  
  Future<void> sendOtp() async {
    if (email.value.isEmpty) return;
    
    isSendingOtp.value = true;
    otpError.value = '';
    
    try {
      await otpRepository.sendOtp(email.value);
      Get.snackbar('Success', 'Verification code sent to ${email.value}');
    } catch (e) {
      otpError.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Failed', otpError.value);
    } finally {
      isSendingOtp.value = false;
    }
  }
  
  Future<void> verifyOtp() async {
    if (otpCode.value.length != 6) {
      otpError.value = 'Please enter the 6-digit verification code';
      return;
    }

    isVerifyingOtp.value = true;
    otpError.value = '';

    try {
      final isValid = await otpRepository.verifyOtp(otpCode.value, email.value);

      if (isValid) {
        Get.offAllNamed(AppRoutes.createBusiness);
        Get.snackbar('Success', 'Email verified successfully!');
      }
    } catch (e) {
      String error = e.toString().replaceFirst('Exception: ', '');
      
      if (error.toLowerCase().contains('invalid') || 
          error.toLowerCase().contains('expired')) {
        otpError.value = 'Invalid or expired verification code. Please request a new one.';
      } else {
        otpError.value = error;
      }
      
      Get.snackbar('Verification Failed', otpError.value);
    } finally {
      isVerifyingOtp.value = false;
    }
  }
  
  Future<void> resendOtp() async {
    if (email.value.isEmpty) return;

    isSendingOtp.value = true;

    try {
      await otpRepository.sendOtp(email.value);
      Get.snackbar('Success', 'New verification code sent to ${email.value}');
      otpCode.value = '';
    } catch (e) {
      otpError.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Failed', otpError.value);
    } finally {
      isSendingOtp.value = false;
    }
  }
}