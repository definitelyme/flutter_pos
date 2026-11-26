import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/data/export.dart';

abstract class UserRemoteDatasource {
  Future<Result<String>> createUser(UserModel user);

  Future<Result<void>> updateUser(UserModel user);

  Future<Result<void>> deleteUser(String id);

  Future<Result<UserModel?>> getUser(String id);
}
