import 'package:get/get.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class ProfileController extends GetxController {
  final AuthRepository authRepository = Get.find();
  final UserService userService = Get.find();
  final SharedPreference sharedPrefs = Get.find();
  
  var userName = ''.obs;
  var userEmail = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    userName.value = userService.firstName.value;
    userEmail.value = userService.email.value;
  }
  
  Future<void> logout() async {
    try {
      await authRepository.logout();
      userService.clearUser();
      sharedPrefs.clearAll();
      Get.offAllNamed(AppRoutes.login);
      Get.snackbar('Success', 'Logged out successfully');
    } catch (e) {
      Get.snackbar('Error', 'Logout failed');
    }
  }
}