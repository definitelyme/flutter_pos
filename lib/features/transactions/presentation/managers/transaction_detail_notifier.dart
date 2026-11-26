import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/features/transactions/domain/export.dart';
import 'package:flutter_pos/managers/export.dart';

final transactionDetailNotifierProvider = NotifierProvider.autoDispose<TransactionDetailNotifier, TransactionEntity?>(
  TransactionDetailNotifier.new,
);

class TransactionDetailNotifier extends AutoDisposeNotifier<TransactionEntity?> {
  @override
  TransactionEntity? build() {
    return null;
  }

  Future<TransactionEntity?> getTransactionDetail(int id) async {
    final transactionRepository = ref.read(transactionRepositoryProvider);
    var res = await GetTransactionUsecase(transactionRepository).call(id);

    if (res.isSuccess) {
      state = res.data;
      return res.data;
    } else {
      throw res.error ?? 'Failed to load data';
    }
  }
}
