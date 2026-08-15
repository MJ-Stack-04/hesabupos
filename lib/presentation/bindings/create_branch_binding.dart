import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/create_branch_controller.dart';

class CreateBranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateBranchController());
  }
}