import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';
import 'package:flutter_pos/features/auth/domain/export.dart';

@injectable
class SignInWithGoogleUsecase extends OpenUseCase<Result> {
  SignInWithGoogleUsecase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<UserEntity?>> execute() async => _authRepository.signInWithGoogle();
}
