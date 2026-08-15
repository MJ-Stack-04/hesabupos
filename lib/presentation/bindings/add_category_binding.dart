
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/add_category_controller.dart';

class AddCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCategoryController>(() => AddCategoryController());
  }
}