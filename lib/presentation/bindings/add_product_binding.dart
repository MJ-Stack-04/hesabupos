
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/add_product_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}