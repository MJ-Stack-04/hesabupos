
import 'package:get/get.dart';
import 'package:hesabuapp/data/dtos/business_dto.dart';
import 'package:hesabuapp/domain/repositories/business_repository.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class CreateBusinessController extends GetxController {
  final BusinessRepository businessRepository = Get.find();
  final AuthRepository authRepository = Get.find();
  final UserService userService = Get.find();

  final businessName = ''.obs;
  final isLoading = false.obs;
  final businessNameError = ''.obs;
  final generalError = ''.obs;

  void setBusinessName(String value) {
    businessName.value = value;
    businessNameError.value = '';
  }

  Future<void> createBusiness() async {
    if (businessName.value.isEmpty) {
      businessNameError.value = 'Business name is required';
      return;
    }

    isLoading.value = true;
    generalError.value = '';

    try {
      final dto = CreateBusinessDto(name: businessName.value);
      final business = await businessRepository.createBusiness(dto);

      userService.setBusiness(
        businessId: business.id,
        businessName: business.name,
      );

      try {
        await authRepository.switchBusiness(business.id);
      } catch (_) {}

      Get.snackbar('Success', 'Business "${business.name}" created!');
      Get.offAllNamed(AppRoutes.createBranch);
    } catch (e) {
      generalError.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Error', generalError.value);
    } finally {
      isLoading.value = false;
    }
  }
}