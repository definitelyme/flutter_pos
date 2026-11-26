import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';

@injectable
class SyncAllUserTransactionsUsecase extends UseCase<Result, String> {
  SyncAllUserTransactionsUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<int>> execute(String params) async => _transactionRepository.syncAllUserTransactions(params);
}
