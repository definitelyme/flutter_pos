import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';

@injectable
class GetUserTransactionsUsecase extends UseCase<Result, BaseParams> {
  GetUserTransactionsUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<List<TransactionEntity>>> execute(BaseParams params) async {
    return _transactionRepository.getUserTransactions(
      params.param,
      orderBy: params.orderBy,
      sortBy: params.sortBy,
      limit: params.limit,
      offset: params.offset,
      contains: params.contains,
    );
  }
}
