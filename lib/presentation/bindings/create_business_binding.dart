import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/create_business_controller.dart';

class CreateBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateBusinessController());
  }
}