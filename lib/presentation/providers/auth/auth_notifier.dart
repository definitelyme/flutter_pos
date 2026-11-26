import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/app/di/app_providers.dart';
import 'package:flutter_pos/core/common/result.dart';
import 'package:flutter_pos/core/utilities/console_logger.dart';
import 'package:flutter_pos/domain/usecases/auth_usecases.dart';
import 'package:flutter_pos/domain/usecases/params/no_param.dart';
import 'package:flutter_pos/domain/usecases/user_usecases.dart';
import 'package:flutter_pos/presentation/providers/auth/auth_state.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    unawaited(_initialize());
    return const AuthState(isChecking: true);
  }

  Future<void> _initialize() async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final res = await GetCurrentUserUsecase(authRepository).call(NoParam());

      final user = res.data;
      cl('isAuthenticated: ${user != null}');

      state = AuthState(user: user);
    } catch (_) {
      state = const AuthState();
    }
  }

  Future<Result<String>> signIn() async {
    final authRepository = ref.read(authRepositoryProvider);
    final userRepository = ref.read(userRepositoryProvider);

    var res = await SignInWithGoogleUsecase(authRepository).call(NoParam());
    if (res.isFailure) return Result.failure(error: res.error!);

    var createRes = await CreateUserUsecase(userRepository).call(res.data!);
    if (createRes.isFailure) return Result.failure(error: createRes.error!);

    state = AuthState(user: res.data!);

    return createRes;
  }

  Future<Result<void>> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);

    final res = await SignOutUsecase(authRepository).call(NoParam());
    if (res.isFailure) return Result.failure(error: res.error!);

    state = const AuthState();

    return Result.success(data: null);
  }
}
