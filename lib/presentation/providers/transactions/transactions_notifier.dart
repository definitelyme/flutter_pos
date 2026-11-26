import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/app/di/app_providers.dart';
import 'package:flutter_pos/domain/usecases/params/base_params.dart';
import 'package:flutter_pos/domain/usecases/transaction_usecases.dart';
import 'package:flutter_pos/presentation/providers/auth/auth_notifier.dart';
import 'package:flutter_pos/presentation/providers/transactions/transactions_state.dart';

final transactionsNotifierProvider = NotifierProvider<TransactionsNotifier, TransactionsState>(
  TransactionsNotifier.new,
);

class TransactionsNotifier extends Notifier<TransactionsState> {
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

    final transactionRepository = ref.read(transactionRepositoryProvider);
    var res = await GetUserTransactionsUsecase(transactionRepository).call(params);

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
