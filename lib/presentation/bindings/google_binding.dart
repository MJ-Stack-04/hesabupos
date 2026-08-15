import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/google_controller.dart';

class GoogleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GoogleController());
  }
}