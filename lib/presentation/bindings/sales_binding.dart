import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/sales_controller.dart';

class SalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SalesController());
  }
}