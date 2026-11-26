import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';
import 'package:flutter_pos/features/auth/domain/export.dart';

class SignInWithGoogleUsecase extends Usecase<Result, NoParam> {
  SignInWithGoogleUsecase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<UserEntity?>> call(NoParam params) async => _authRepository.signInWithGoogle();
}

class SignOutUsecase extends Usecase<Result, NoParam> {
  SignOutUsecase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<void>> call(NoParam params) async => _authRepository.signOut();
}

class GetCurrentUserUsecase extends Usecase<Result, NoParam> {
  GetCurrentUserUsecase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<UserEntity?>> call(NoParam params) async => _authRepository.getCurrentUser();
}
