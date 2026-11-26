import 'package:flutter_pos/core/common/result.dart';
import 'package:flutter_pos/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<Result<UserModel>> signInWithGoogle();

  Future<Result<void>> signOut();

  Future<Result<UserModel?>> getCurrentUser();
}
