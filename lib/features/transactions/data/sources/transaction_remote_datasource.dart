import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/transactions/data/export.dart';

abstract class TransactionRemoteDatasource {
  Future<Result<int>> createTransaction(TransactionModel transaction);

  Future<Result<void>> updateTransaction(TransactionModel transaction);

  Future<Result<void>> deleteTransaction(int id);

  Future<Result<TransactionModel?>> getTransaction(int id);

  Future<Result<List<TransactionModel>>> getAllUserTransactions(String userId);

  Future<Result<List<TransactionModel>>> getUserTransactions(
    String userId, {
    String orderBy,
    String sortBy,
    int limit,
    int? offset,
    String? contains,
  });
}
