import 'package:get/get.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class RegisterController extends GetxController {
  final AuthRepository authRepository = Get.find();
  final UserService userService = Get.find();
  final SharedPreference sharedPrefs = Get.find();
  
  var isRegisterLoading = false.obs;
  var registerEmail = ''.obs;
  var registerPhone = ''.obs;
  var registerPassword = ''.obs;
  var registerRepeatPassword = ''.obs;
  var registerFirstName = ''.obs;
  var registerLastName = ''.obs;
  var registerObscurePassword = true.obs;
  var registerObscureRepeatPassword = true.obs;
  var registerEmailError = ''.obs;
  var registerPhoneError = ''.obs;
  var registerPasswordError = ''.obs;
  var registerRepeatPasswordError = ''.obs;
  var registerFirstNameError = ''.obs;
  var registerLastNameError = ''.obs;
  var registerGeneralError = ''.obs;
  
  void setRegisterEmail(String value) {
    registerEmail.value = value;
    registerEmailError.value = '';
  }
  
  void setRegisterPhone(String value) {
    registerPhone.value = value;
    registerPhoneError.value = '';
  }
  
  void setRegisterPassword(String value) {
    registerPassword.value = value;
    registerPasswordError.value = '';
  }
  
  void setRegisterRepeatPassword(String value) {
    registerRepeatPassword.value = value;
    registerRepeatPasswordError.value = '';
  }
  
  void setRegisterFirstName(String value) {
    registerFirstName.value = value;
    registerFirstNameError.value = '';
  }
  
  void setRegisterLastName(String value) {
    registerLastName.value = value;
    registerLastNameError.value = '';
  }
  
  void toggleRegisterPasswordVisibility() {
    registerObscurePassword.toggle();
  }
  
  void toggleRegisterRepeatPasswordVisibility() {
    registerObscureRepeatPassword.toggle();
  }
  
  Future<void> register() async {
    registerEmailError.value = '';
    registerPhoneError.value = '';
    registerPasswordError.value = '';
    registerRepeatPasswordError.value = '';
    registerFirstNameError.value = '';
    registerLastNameError.value = '';
    registerGeneralError.value = '';
    
    if (registerFirstName.value.isEmpty) {
      registerFirstNameError.value = 'First name is required';
      return;
    }
    if (registerLastName.value.isEmpty) {
      registerLastNameError.value = 'Last name is required';
      return;
    }
    if (registerEmail.value.isEmpty) {
      registerEmailError.value = 'Email is required';
      return;
    }
    if (!GetUtils.isEmail(registerEmail.value)) {
      registerEmailError.value = 'Enter a valid email';
      return;
    }
    if (registerPhone.value.isEmpty) {
      registerPhoneError.value = 'Phone number is required';
      return;
    }
    if (registerPassword.value.isEmpty) {
      registerPasswordError.value = 'Password is required';
      return;
    }
    if (registerPassword.value.length < 6) {
      registerPasswordError.value = 'Password must be at least 6 characters';
      return;
    }
    if (registerRepeatPassword.value != registerPassword.value) {
      registerRepeatPasswordError.value = 'Passwords do not match';
      return;
    }
    
    isRegisterLoading.value = true;
    
    try {
      final auth = await authRepository.register(
        registerEmail.value,
        registerPassword.value,
        registerFirstName.value,
        registerLastName.value,
        registerPhone.value,
      );
      
      sharedPrefs.saveToken(auth.token);
      sharedPrefs.saveRefreshToken(auth.refreshToken);
      
      userService.setUser(
        firstName: auth.user.firstName,
        lastName: auth.user.lastName,
        email: auth.user.email,
        phone: auth.user.phone,
        userId: auth.user.id,
      );
      
      Get.snackbar('Success', 'Account created! Please verify your email.');
      Get.toNamed(AppRoutes.otp, arguments: registerEmail.value);
      registerGeneralError.value = '';
      
    } catch (e) {
      registerGeneralError.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Registration Failed', registerGeneralError.value);
    } finally {
      isRegisterLoading.value = false;
    }
  }
}