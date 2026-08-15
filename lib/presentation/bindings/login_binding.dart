import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/login_controller.dart';
import 'package:hesabuapp/presentation/controllers/google_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(GoogleController());
  }
}