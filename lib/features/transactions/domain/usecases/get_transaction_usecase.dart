import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';

@injectable
class GetTransactionUsecase extends UseCase<Result, int> {
  GetTransactionUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<TransactionEntity?>> execute(int params) async => _transactionRepository.getTransaction(params);
}
