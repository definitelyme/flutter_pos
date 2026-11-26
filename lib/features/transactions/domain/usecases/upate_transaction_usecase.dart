import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';

@injectable
class UpateTransactionUsecase extends UseCase<Result<void>, TransactionEntity> {
  UpateTransactionUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<void>> execute(TransactionEntity params) async => _transactionRepository.updateTransaction(params);
}
