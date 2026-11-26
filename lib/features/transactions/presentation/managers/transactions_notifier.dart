import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/auth/presentation/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';
import 'package:flutter_pos/features/transactions/presentation/export.dart';
import 'package:flutter_pos/managers/export.dart';

final transactionsNotifierProvider = NotifierProvider<TransactionsNotifier, TransactionsState>(
  TransactionsNotifier.new,
);

class TransactionsNotifier extends Notifier<TransactionsState> {
  GetUserTransactionsUsecase get _getUserTransactions => getIt();

  @override
  TransactionsState build() {
    return const TransactionsState();
  }

  String _requireUserId() {
    final authState = ref.read(authNotifierProvider);
    if (authState.isAuthenticated) return authState.user!.id;
    throw 'Unauthenticated!';
  }

  void resetTransactions() {
    state = const TransactionsState();
  }

  Future<void> getAllTransactions({int? offset, String? contains}) async {
    final userId = _requireUserId();

    if (offset != null) {
      state = state.copyWith(isLoadingMore: true);
    }

    var params = BaseParams(
      param: userId,
      offset: offset,
      contains: contains,
    );

    var res = await _getUserTransactions.execute(params);

    if (res.isSuccess) {
      if (offset == null) {
        state = state.copyWith(allTransactions: res.data ?? [], isLoadingMore: false);
      } else {
        final current = state.allTransactions ?? [];
        state = state.copyWith(
          allTransactions: [...current, ...res.data ?? []],
          isLoadingMore: false,
        );
      }
    } else {
      state = state.copyWith(isLoadingMore: false);
      throw res.error ?? 'Failed to load data';
    }
  }
}
