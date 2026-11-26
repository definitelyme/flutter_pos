import 'package:flutter_pos/core/common/result.dart';
import 'package:flutter_pos/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Result<UserEntity?>> getUser(String userId);
  Future<Result<String>> createUser(UserEntity user);
  Future<Result<void>> updateUser(UserEntity user);
  Future<Result<void>> deleteUser(String userId);
}
