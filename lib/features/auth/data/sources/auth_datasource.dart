import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/data/export.dart';

abstract class AuthDataSource {
  Future<Result<UserModel>> signInWithGoogle();

  Future<Result<void>> signOut();

  Future<Result<UserModel?>> getCurrentUser();
}
