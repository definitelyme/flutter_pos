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
  GetCurrentUserUsecase get _getCurrentUser => getIt();
  SignInWithGoogleUsecase get _signInWithGoogle => getIt();
  SignInWithTestAccountUsecase get _signInWithTestAccount => getIt();
  CreateUserUsecase get _createUser => getIt();
  SignOutUsecase get _signOut => getIt();

  @override
  AuthState build() {
    unawaited(_initialize());
    return const AuthState(isChecking: true);
  }

  Future<void> _initialize() async {
    try {
      final res = await _getCurrentUser.execute();

      final user = res.data;
      cl('isAuthenticated: ${user != null}');

      state = AuthState(user: user);
    } catch (_) {
      state = const AuthState();
    }
  }

  Future<Result<String>> signIn() async {
    var res = await _signInWithGoogle.execute();
    if (res.isFailure) return Result.failure(error: res.error!);

    var createRes = await _createUser.execute(res.data!);
    if (createRes.isFailure) return Result.failure(error: createRes.error!);

    state = AuthState(user: res.data!);

    return createRes;
  }

  Future<Result<String>> signInWithTestAccount() async {
    var res = await _signInWithTestAccount.execute();
    if (res.isFailure) return Result.failure(error: res.error!);

    var createRes = await _createUser.execute(res.data!);
    if (createRes.isFailure) return Result.failure(error: createRes.error!);

    state = AuthState(user: res.data!);

    return createRes;
  }

  Future<Result<void>> signOut() async {
    final res = await _signOut.execute();
    if (res.isFailure) return Result.failure(error: res.error!);

    state = const AuthState();

    return Result.success(data: null);
  }
}
