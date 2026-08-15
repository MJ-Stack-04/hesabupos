
import 'package:get/get.dart';
import 'package:hesabuapp/data/dtos/branch_dto.dart';
import 'package:hesabuapp/domain/repositories/branch_repository.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

class CreateBranchController extends GetxController {
  final BranchRepository branchRepository = Get.find();
  final AuthRepository authRepository = Get.find();
  final UserService userService = Get.find();

  final branchName = ''.obs;
  final branchLocation = ''.obs;
  final branchDescription = ''.obs;
  final isLoading = false.obs;
  final branchNameError = ''.obs;
  final branchLocationError = ''.obs;
  final generalError = ''.obs;

  void setBranchName(String value) {
    branchName.value = value;
    branchNameError.value = '';
  }

  void setBranchLocation(String value) {
    branchLocation.value = value;
    branchLocationError.value = '';
  }

  void setBranchDescription(String value) {
    branchDescription.value = value;
  }

  Future<void> createBranch() async {
    branchNameError.value = '';
    branchLocationError.value = '';
    generalError.value = '';

    if (branchName.value.isEmpty) {
      branchNameError.value = 'Branch name is required';
      return;
    }
    if (branchLocation.value.isEmpty) {
      branchLocationError.value = 'Branch location is required';
      return;
    }

    isLoading.value = true;

    try {
      final dto = CreateBranchDto(
        name: branchName.value,
        location: branchLocation.value,
        description: branchDescription.value.isEmpty ? null : branchDescription.value,
      );

      final branch = await branchRepository.createBranch(dto);

      userService.setBranch(
        branchId: branch.id,
        branchName: branch.name,
      );

      try {
        await authRepository.switchBranch(branch.id);
      } catch (_) {}

      Get.snackbar('Success', 'Branch "${branch.name}" created!');
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      generalError.value = e.toString().replaceFirst('Exception: ', '');
      Get.snackbar('Error', generalError.value);
    } finally {
      isLoading.value = false;
    }
  }
}