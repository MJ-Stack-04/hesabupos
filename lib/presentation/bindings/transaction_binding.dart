import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/transaction_controller.dart';

class TransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionsController());
  }
}