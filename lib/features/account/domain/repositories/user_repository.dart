import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';

abstract class UserRepository {
  Future<Result<UserEntity?>> getUser(String userId);
  Future<Result<String>> createUser(UserEntity user);
  Future<Result<void>> updateUser(UserEntity user);
  Future<Result<void>> deleteUser(String userId);
}
