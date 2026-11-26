import 'package:flutter_pos/core/common/result.dart';
import 'package:flutter_pos/core/usecase/usecase.dart';
import 'package:flutter_pos/domain/entities/transaction_entity.dart';
import 'package:flutter_pos/domain/repositories/transaction_repository.dart';
import 'package:flutter_pos/domain/usecases/params/base_params.dart';

class SyncAllUserTransactionsUsecase extends Usecase<Result, String> {
  SyncAllUserTransactionsUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<int>> call(String params) async => _transactionRepository.syncAllUserTransactions(params);
}

class GetUserTransactionsUsecase extends Usecase<Result, BaseParams> {
  GetUserTransactionsUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<List<TransactionEntity>>> call(BaseParams params) async {
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

class GetTransactionUsecase extends Usecase<Result, int> {
  GetTransactionUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<TransactionEntity?>> call(int params) async => _transactionRepository.getTransaction(params);
}

class CreateTransactionUsecase extends Usecase<Result, TransactionEntity> {
  CreateTransactionUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<int>> call(TransactionEntity params) async => _transactionRepository.createTransaction(params);
}

class UpateTransactionUsecase extends Usecase<Result<void>, TransactionEntity> {
  UpateTransactionUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<void>> call(TransactionEntity params) async => _transactionRepository.updateTransaction(params);
}

class DeleteTransactionUsecase extends Usecase<Result<void>, int> {
  DeleteTransactionUsecase(this._transactionRepository);

  final TransactionRepository _transactionRepository;

  @override
  Future<Result<void>> call(int params) async => _transactionRepository.deleteTransaction(params);
}
