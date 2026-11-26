import 'package:flutter_pos/core/common/result.dart';
import 'package:flutter_pos/core/usecase/usecase.dart';
import 'package:flutter_pos/domain/entities/user_entity.dart';
import 'package:flutter_pos/domain/repositories/auth_repository.dart';
import 'package:flutter_pos/domain/usecases/params/no_param.dart';

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
