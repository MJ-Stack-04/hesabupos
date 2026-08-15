
import 'package:get/get.dart';
import 'package:hesabuapp/presentation/bindings/login_binding.dart';
import 'package:hesabuapp/presentation/bindings/register_binding.dart';
import 'package:hesabuapp/presentation/bindings/otp_binding.dart';
import 'package:hesabuapp/presentation/bindings/create_business_binding.dart';
import 'package:hesabuapp/presentation/bindings/create_branch_binding.dart';
import 'package:hesabuapp/presentation/bindings/dashboard_binding.dart';
import 'package:hesabuapp/presentation/bindings/forgot_password_binding.dart';
import 'package:hesabuapp/presentation/bindings/reset_password_binding.dart';
import 'package:hesabuapp/presentation/bindings/product_binding.dart';
import 'package:hesabuapp/presentation/bindings/add_product_binding.dart';
import 'package:hesabuapp/presentation/bindings/category_binding.dart';
import 'package:hesabuapp/presentation/bindings/add_category_binding.dart';
import 'package:hesabuapp/presentation/screens/login_screen.dart';
import 'package:hesabuapp/presentation/screens/products_screen.dart';
import 'package:hesabuapp/presentation/screens/register_screen.dart';
import 'package:hesabuapp/presentation/screens/otp_screen.dart';
import 'package:hesabuapp/presentation/screens/create_business_screen.dart';
import 'package:hesabuapp/presentation/screens/create_branch_screen.dart';
import 'package:hesabuapp/presentation/screens/dashboard_screen.dart';
import 'package:hesabuapp/presentation/screens/forgot_password_screen.dart';
import 'package:hesabuapp/presentation/screens/reset_password_screen.dart';
import 'package:hesabuapp/presentation/screens/add_product_screen.dart';
import 'package:hesabuapp/presentation/screens/categories_screen.dart';
import 'package:hesabuapp/presentation/screens/add_category_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.createBusiness,
      page: () => const CreateBusinessScreen(),
      binding: CreateBusinessBinding(),
    ),
    GetPage(
      name: AppRoutes.createBranch,
      page: () => const CreateBranchScreen(),
      binding: CreateBranchBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductsScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.addProduct,
      page: () => const AddProductScreen(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => const CategoriesScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.addCategory,
      page: () => const AddCategoryScreen(),
      binding: AddCategoryBinding(),
    ),
  ];
}