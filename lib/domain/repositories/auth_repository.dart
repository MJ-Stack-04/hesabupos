import 'package:hesabuapp/domain/entities/auth.dart';
import 'package:hesabuapp/domain/entities/business.dart';

abstract class AuthRepository {
  Future<Auth> login(String email, String password);
  Future<Auth> register(String email, String password, String firstName, String lastName, String phone);
  Future<void> logout();
  Future<void> switchBranch(String branchId);
  Future<Business> switchBusiness(String businessId);
}