import 'package:flutter_pos/features/account/domain/export.dart';

class AuthState {
  final bool isChecking;
  final UserEntity? user;

  const AuthState({this.isChecking = false, this.user});

  bool get isAuthenticated => user != null;

  AuthState copyWith({bool? isChecking, UserEntity? user}) {
    return AuthState(
      isChecking: isChecking ?? this.isChecking,
      user: user ?? this.user,
    );
  }
}
