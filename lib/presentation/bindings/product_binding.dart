
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/products_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsController());
  }
}