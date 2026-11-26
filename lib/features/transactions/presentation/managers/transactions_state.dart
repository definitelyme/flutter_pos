import 'package:flutter_pos/features/transactions/domain/export.dart';

class TransactionsState {
  final List<TransactionEntity>? allTransactions;
  final bool isLoadingMore;

  const TransactionsState({this.allTransactions, this.isLoadingMore = false});

  TransactionsState copyWith({
    List<TransactionEntity>? allTransactions,
    bool? isLoadingMore,
  }) {
    return TransactionsState(
      allTransactions: allTransactions ?? this.allTransactions,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
