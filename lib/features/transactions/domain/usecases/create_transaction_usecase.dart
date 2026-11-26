import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';

@injectable
class CreateTransactionUsecase extends UseCase<Result, TransactionEntity> {
  CreateTransactionUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<int>> execute(TransactionEntity params) async => _transactionRepository.createTransaction(params);
}
