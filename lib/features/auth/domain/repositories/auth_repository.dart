// lib/features/auth/domain/repositories/auth_repository.dart

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> signInWithGoogle();

  Future<Result<UserEntity>> signInWithTestAccount();

  Future<Result<void>> signOut();

  Future<Result<UserEntity?>> getCurrentUser();
}
