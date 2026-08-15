
import 'package:hesabuapp/data/dtos/business_dto.dart';
import 'package:hesabuapp/domain/entities/business.dart';

abstract class BusinessRepository {
  Future<List<Business>> getBusinesses();
  Future<Business> getBusinessById(String id);
  Future<Business> createBusiness(CreateBusinessDto dto);
  Future<Business> updateBusiness(String id, UpdateBusinessDto dto);
  Future<void> deleteBusiness(String id);
  Future<Business> getCurrentBusiness();
}