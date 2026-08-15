import 'package:get/get.dart';

class GoogleController extends GetxController {
  var isGoogleLoading = false.obs;
  
  Future<void> loginWithGoogle() async {
    isGoogleLoading.value = true;
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      Get.snackbar('Google Login', 'Coming soon');
    } catch (e) {
      Get.snackbar('Google Login Failed', e.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }
}