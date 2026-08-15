import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpController());
  }
}