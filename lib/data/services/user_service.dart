import 'package:get/get.dart';

class UserService extends GetxService {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var userId = ''.obs;
  
  var businessId = ''.obs;
  var branchId = ''.obs;
  var businessName = ''.obs;
  var branchName = ''.obs;
  
  void setUser({
    required String firstName,
    required String lastName,
    required String email,
    String? phone,
    String? userId,
  }) {
    this.firstName.value = firstName;
    this.lastName.value = lastName;
    this.email.value = email;
    if (phone != null) this.phone.value = phone;
    if (userId != null) this.userId.value = userId;
  }
  
  void setBusiness({
    required String businessId,
    required String businessName,
  }) {
    this.businessId.value = businessId;
    this.businessName.value = businessName;
  }
  
  void setBranch({
    required String branchId,
    required String branchName,
  }) {
    this.branchId.value = branchId;
    this.branchName.value = branchName;
  }
  
  void clearUser() {
    firstName.value = '';
    lastName.value = '';
    email.value = '';
    phone.value = '';
    userId.value = '';
    businessId.value = '';
    branchId.value = '';
    businessName.value = '';
    branchName.value = '';
  }
}