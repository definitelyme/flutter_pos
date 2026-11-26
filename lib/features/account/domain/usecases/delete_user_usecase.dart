import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';

@injectable
class DeleteUserUsecase extends UseCase<Result<void>, String> {
  DeleteUserUsecase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Future<Result<void>> execute(String params) async => _userRepository.deleteUser(params);
}
