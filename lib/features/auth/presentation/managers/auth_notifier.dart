import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';
import 'package:flutter_pos/features/auth/domain/export.dart';
import 'package:flutter_pos/features/auth/presentation/export.dart';
import 'package:flutter_pos/managers/export.dart';
import 'package:flutter_pos/utils/utils.dart';

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
