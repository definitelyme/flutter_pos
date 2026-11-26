import 'dart:convert';

import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/data/export.dart';
import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/sync/queued_action/data/export.dart';
import 'package:flutter_pos/core/sync/queued_action/domain/export.dart';
import 'package:flutter_pos/features/account/data/export.dart';
import 'package:flutter_pos/features/products/data/export.dart';
import 'package:flutter_pos/features/transactions/data/export.dart';
import 'package:flutter_pos/utils/utils.dart';

@LazySingleton(as: QueuedActionRepository)
class QueuedActionRepositoryImpl extends QueuedActionRepository {
  final PingService pingService;
  final QueuedActionDatasource queuedActionLocalDatasource;
  final UserRemoteDatasource userRemoteDatasource;
  final TransactionRemoteDatasource transactionRemoteDatasource;
  final ProductRemoteDatasource productRemoteDatasource;

  QueuedActionRepositoryImpl({
    required this.pingService,
    required this.queuedActionLocalDatasource,
    required this.userRemoteDatasource,
    required this.transactionRemoteDatasource,
    required this.productRemoteDatasource,
  });

  @override
  Future<Result<List<QueuedActionEntity>>> getAllQueuedAction() async {
    try {
      final res = await queuedActionLocalDatasource.getAllUserQueuedAction();
      if (res.isFailure) return Result.failure(error: res.error!);

      return Result.success(data: res.data!.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<List<bool>>> executeAllQueuedActions(List<QueuedActionEntity> queues) async {
    try {
      if (queues.isEmpty) return Result.success(data: []);

      List<bool> result = [];

      for (final queue in queues) {
        // Pass if the internet goes off in the process
        if (!pingService.isConnected) continue;

        final res = await executeQueuedAction(queue);

        result.add(res.isSuccess);
      }

      return Result.success(data: result);
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<bool>> executeQueuedAction(QueuedActionEntity queue) async {
    try {
      cl(QueuedActionModel.fromEntity(queue).toJson());

      final res = await _functionSelector(queue);

      if (res.isSuccess) {
        // Delete executed queue from db
        final deleteRes = await queuedActionLocalDatasource.deleteQueuedAction(queue.id!);
        if (deleteRes.isFailure) return Result.failure(error: res.error!);

        return Result.success(data: true);
      } else {
        return Result.failure(error: res.error ?? 'Unknown error');
      }
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  Future<Result<Null>> _functionSelector(QueuedActionEntity queue) async {
    try {
      if (queue.repository == 'UserRepositoryImpl') {
        if (queue.method == 'createUser') {
          UserModel param = UserModel.fromJson(jsonDecode(queue.param));

          final res = await userRemoteDatasource.createUser(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }

        if (queue.method == 'deleteUser') {
          final param = queue.param;

          final res = await userRemoteDatasource.deleteUser(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }

        if (queue.method == 'updateUser') {
          UserModel param = UserModel.fromJson(jsonDecode(queue.param));

          final res = await userRemoteDatasource.updateUser(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }
      }

      if (queue.repository == 'TransactionRepositoryImpl') {
        if (queue.method == 'createTransaction') {
          TransactionModel param = TransactionModel.fromJson(jsonDecode(queue.param));

          final res = await transactionRemoteDatasource.createTransaction(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }

        if (queue.method == 'deleteTransaction') {
          final param = int.parse(queue.param);

          final res = await transactionRemoteDatasource.deleteTransaction(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }

        if (queue.method == 'updateTransaction') {
          TransactionModel param = TransactionModel.fromJson(jsonDecode(queue.param));

          final res = await transactionRemoteDatasource.updateTransaction(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }
      }

      if (queue.repository == 'ProductRepositoryImpl') {
        if (queue.method == 'createProduct') {
          ProductModel param = ProductModel.fromJson(jsonDecode(queue.param));

          final res = await productRemoteDatasource.createProduct(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }

        if (queue.method == 'deleteProduct') {
          final param = int.parse(queue.param);

          final res = await productRemoteDatasource.deleteProduct(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }

        if (queue.method == 'updateProduct') {
          ProductModel param = ProductModel.fromJson(jsonDecode(queue.param));

          final res = await productRemoteDatasource.updateProduct(param);
          if (res.isFailure) return Result.failure(error: res.error!);

          return Result.success(data: null);
        }
      }

      return Result.success(data: null);
    } catch (e) {
      return Result.failure(error: e);
    }
  }
}
