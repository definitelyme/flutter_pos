import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';

@injectable
class GetUserUsecase extends UseCase<Result, String> {
  GetUserUsecase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<UserEntity?>> execute(String params) async => _userRepository.getUser(params);
}
