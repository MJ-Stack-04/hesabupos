import 'package:get/get.dart';
import 'package:hesabuapp/presentation/controllers/dashboard_controller.dart';
import 'package:hesabuapp/presentation/controllers/home_controller.dart';
import 'package:hesabuapp/presentation/controllers/products_controller.dart';
import 'package:hesabuapp/presentation/controllers/profile_controller.dart';
import 'package:hesabuapp/presentation/controllers/transaction_controller.dart';
import 'package:hesabuapp/presentation/controllers/sales_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => TransactionsController());
    Get.lazyPut(() => ProductsController());
    Get.lazyPut(() => SalesController());
  }
}