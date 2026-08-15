import 'package:get/get.dart';
import 'package:hesabuapp/data/repositoryimpl/auth_repository_impl.dart';
import 'package:hesabuapp/data/repositoryimpl/branch_repository_impl.dart';
import 'package:hesabuapp/data/repositoryimpl/business_repository_impl.dart';
import 'package:hesabuapp/data/repositoryimpl/category_repository_impl.dart';
import 'package:hesabuapp/data/repositoryimpl/otp_repository_impl.dart';
import 'package:hesabuapp/data/repositoryimpl/product_repository_impl.dart';
import 'package:hesabuapp/data/repositoryimpl/reset_password_repository_impl.dart';
import 'package:hesabuapp/data/repositoryimpl/sale_repository_impl.dart';
import 'package:hesabuapp/data/repositoryimpl/transaction_repository_impl.dart';
import 'package:hesabuapp/data/services/api_client.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';
import 'package:hesabuapp/domain/repositories/otp_repository.dart';
import 'package:hesabuapp/domain/repositories/business_repository.dart';
import 'package:hesabuapp/domain/repositories/branch_repository.dart';
import 'package:hesabuapp/domain/repositories/category_repository.dart';
import 'package:hesabuapp/domain/repositories/reset_password_repository.dart';
import 'package:hesabuapp/domain/repositories/sale_repository.dart';
import 'package:hesabuapp/domain/repositories/transaction_repository.dart';
import 'package:hesabuapp/domain/repositories/product_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.putAsync<SharedPreference>(() async {
      final sharedPreference = SharedPreference();
      await sharedPreference.init();
      return sharedPreference;
    });
    Get.put(ApiClient());
    Get.put(UserService());

    Get.put<AuthRepository>(AuthRepositoryImpl(Get.find(), Get.find(), Get.find()));
    Get.put<BranchRepository>(BranchRepositoryImpl(Get.find(), Get.find(), Get.find()));
    Get.put<BusinessRepository>(BusinessRepositoryImpl(Get.find(), Get.find(), Get.find()));
    Get.put<CategoryRepository>(CategoryRepositoryImpl(Get.find(), Get.find())); 
    Get.put<OtpRepository>(OtpRepositoryImpl(Get.find()));
    Get.put<ResetPasswordRepository>(ResetPasswordRepositoryImpl(Get.find()));
    Get.put<TransactionRepository>(TransactionRepositoryImpl(Get.find()));
    Get.put<ProductRepository>(ProductRepositoryImpl(Get.find(), Get.find()));
  }
}