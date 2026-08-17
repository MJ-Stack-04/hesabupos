import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository = Get.find();
  final UserService userService = Get.find();
  final SharedPreference sharedPrefs = Get.find();

  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var obscurePassword = true.obs;
  var emailError = ''.obs;
  var passwordError = ''.obs;
  var generalError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkExistingSession();
  }

  void _checkExistingSession() {
    final token = sharedPrefs.getToken();

    if (token != null && token.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(AppRoutes.dashboard);
      });
    }
  }

  void setEmail(String value) {
    email.value = value;
    emailError.value = '';
  }

  void setPassword(String value) {
    password.value = value;
    passwordError.value = '';
  }

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  Future<void> login() async {
    emailError.value = '';
    passwordError.value = '';
    generalError.value = '';

    if (email.value.isEmpty) {
      emailError.value = 'Email is required';
      return;
    }
    if (!GetUtils.isEmail(email.value)) {
      emailError.value = 'Enter a valid email';
      return;
    }
    if (password.value.isEmpty) {
      passwordError.value = 'Password is required';
      return;
    }
    if (password.value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return;
    }

    isLoading.value = true;

    try {
      final auth = await authRepository.login(email.value, password.value);

      sharedPrefs.saveToken(auth.token);
      sharedPrefs.saveRefreshToken(auth.refreshToken);

      userService.setUser(
        firstName: auth.user.firstName,
        lastName: auth.user.lastName,
        email: auth.user.email,
        phone: auth.user.phone,
        userId: auth.user.id,
      );

      Get.snackbar(
        'Welcome back!',
        'Hello ${auth.user.firstName}',
        snackPosition: SnackPosition.BOTTOM,
      );

      generalError.value = '';
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      generalError.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Login Failed', generalError.value);
    } finally {
      isLoading.value = false;
    }
  }
}
