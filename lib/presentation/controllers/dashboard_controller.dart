
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/user_service.dart';
import 'package:hesabuapp/domain/repositories/branch_repository.dart';
import 'package:hesabuapp/domain/repositories/auth_repository.dart';

class DashboardController extends GetxController {
  final BranchRepository branchRepository = Get.find();
  final AuthRepository authRepository = Get.find();
  final UserService userService = Get.find();

  var selectedIndex = 0.obs;
  var isBranchLoading = true.obs;
  var branchLoaded = false.obs;
  var branchError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBranch();
  }

  Future<void> loadBranch() async {
    if (branchLoaded.value) {
      return;
    }

    if (userService.branchId.value.isNotEmpty) {
      branchLoaded.value = true;
      isBranchLoading.value = false;
      return;
    }

    isBranchLoading.value = true;
    branchError.value = '';

    try {
      final allBranches = await branchRepository.getBranches();

      if (allBranches.isEmpty) {
        branchError.value = 'No branches found. Please create a branch first.';
        isBranchLoading.value = false;
        return;
      }

      final firstBranch = allBranches.first;

      try {
        await authRepository.switchBranch(firstBranch.id);
        branchLoaded.value = true;
      } catch (e) {
        userService.setBranch(
          branchId: firstBranch.id,
          branchName: firstBranch.name,
        );
        branchLoaded.value = true;
      }

      if (userService.branchId.value.isEmpty) {
        try {
          final currentBranch = await branchRepository.getCurrentBranch();
          if (currentBranch.id.isNotEmpty) {
            userService.setBranch(
              branchId: currentBranch.id,
              branchName: currentBranch.name,
            );
            branchLoaded.value = true;
          }
        } catch (_) {
          userService.setBranch(
            branchId: firstBranch.id,
            branchName: firstBranch.name,
          );
          branchLoaded.value = true;
        }
      }

      branchError.value = '';
    } catch (e) {
      branchError.value = 'Failed to load branch. Please try again.';
      Get.snackbar('Error', branchError.value);
    } finally {
      isBranchLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  bool get isLoading => isBranchLoading.value;
  String get error => branchError.value;
}