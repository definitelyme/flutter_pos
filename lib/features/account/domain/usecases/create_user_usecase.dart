import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';

@injectable
class CreateUserUsecase extends UseCase<Result, UserEntity> {
  CreateUserUsecase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<String>> execute(UserEntity params) async {
    final currentUser = await _userRepository.getUser(params.id);

    if (currentUser.data != null) {
      return Result.success(data: currentUser.data!.id);
    }

    return await _userRepository.createUser(params);
  }
}
