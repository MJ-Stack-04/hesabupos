import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/register_controller.dart';
import 'package:hesabuapp/presentation/controllers/google_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController()); 
    Get.put(GoogleController());
  }
}