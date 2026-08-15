
import 'package:hesabuapp/data/dtos/branch_dto.dart';
import 'package:hesabuapp/domain/entities/branch.dart';

abstract class BranchRepository {
  Future<List<Branch>> getBranches();
  Future<Branch> getBranchById(String id);
  Future<Branch> createBranch(CreateBranchDto dto);
  Future<Branch> updateBranch(String id, UpdateBranchDto dto);
  Future<void> deleteBranch(String id);
  Future<Branch> getCurrentBranch();
}