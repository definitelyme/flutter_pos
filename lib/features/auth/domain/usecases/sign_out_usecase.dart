import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/auth/domain/export.dart';

@injectable
class SignOutUsecase extends OpenUseCase<Result> {
  SignOutUsecase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Result<void>> execute() async => _authRepository.signOut();
}
