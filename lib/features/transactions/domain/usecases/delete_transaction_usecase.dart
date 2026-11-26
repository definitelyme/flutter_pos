import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';

@injectable
class DeleteTransactionUsecase extends UseCase<Result<void>, int> {
  DeleteTransactionUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<void>> execute(int params) async => _transactionRepository.deleteTransaction(params);
}
