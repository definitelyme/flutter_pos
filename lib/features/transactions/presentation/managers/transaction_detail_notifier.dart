import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/features/transactions/domain/export.dart';
import 'package:flutter_pos/managers/export.dart';

final transactionDetailNotifierProvider = NotifierProvider.autoDispose<TransactionDetailNotifier, TransactionEntity?>(
  TransactionDetailNotifier.new,
);

class TransactionDetailNotifier extends AutoDisposeNotifier<TransactionEntity?> {
  GetTransactionUsecase get _getTransaction => getIt();

  @override
  TransactionEntity? build() {
    return null;
  }

  Future<TransactionEntity?> getTransactionDetail(int id) async {
    var res = await _getTransaction.execute(id);

    if (res.isSuccess) {
      state = res.data;
      return res.data;
    } else {
      throw res.error ?? 'Failed to load data';
    }
  }
}
