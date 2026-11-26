import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/storage/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart' hide AuthProvider;
import 'package:flutter_pos/features/account/presentation/export.dart';
import 'package:flutter_pos/features/auth/presentation/export.dart';
import 'package:flutter_pos/managers/export.dart';

final accountNotifierProvider = NotifierProvider.autoDispose<AccountNotifier, AccountFormState>(
  AccountNotifier.new,
);

class AccountNotifier extends AutoDisposeNotifier<AccountFormState> {
  @override
  AccountFormState build() {
    return const AccountFormState();
  }

  String _requireUserId() {
    final authState = ref.read(authNotifierProvider);
    if (authState.isAuthenticated) return authState.user!.id;
    throw 'Unauthenticated!';
  }

  Future<void> initProfileForm() async {
    final userId = _requireUserId();
    final userRepository = ref.read(userRepositoryProvider);

    var res = await GetUserUsecase(userRepository).call(userId);

    if (res.isSuccess) {
      state = state.copyWith(
        imageUrl: res.data?.imageUrl,
        name: res.data?.name,
        email: res.data?.email,
        phone: res.data?.phone,
        isLoaded: true,
      );
    } else {
      throw res.error ?? 'Failed to load data';
    }
  }

  Future<Result<void>> updatedUser() async {
    try {
      final userId = _requireUserId();
      final storageRepository = ref.read(storageRepositoryProvider);
      final userRepository = ref.read(userRepositoryProvider);

      var imageUrl = state.imageUrl;

      if (state.imageFile != null) {
        final res = await UploadUserPhotoUsecase(storageRepository).call(state.imageFile!.path);
        imageUrl = res.data;
      }

      var user = UserEntity(
        id: userId,
        email: state.email,
        phone: state.phone,
        name: state.name!,
        imageUrl: imageUrl ?? '',
      );

      var res = await UpateUserUsecase(userRepository).call(user);

      return res;
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  void onChangedImage(File value) {
    state = state.copyWith(imageFile: value);
  }

  void onChangedName(String value) {
    state = state.copyWith(name: value);
  }

  void onChangedEmail(String value) {
    state = state.copyWith(email: value);
  }

  void onChangedPhone(String value) {
    state = state.copyWith(phone: value);
  }
}
