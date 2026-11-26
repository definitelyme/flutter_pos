import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';

@injectable
class UpateUserUsecase extends UseCase<Result<void>, UserEntity> {
  UpateUserUsecase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<void>> execute(UserEntity params) async => _userRepository.updateUser(params);
}
