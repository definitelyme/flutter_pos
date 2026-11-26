import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_pos/core/data/export.dart';
import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/sync/queued_action/data/export.dart';

@LazySingleton(as: QueuedActionDatasource)
class QueuedActionLocalDatasourceImpl extends QueuedActionDatasource {
  final DatabaseService _databaseService;

  QueuedActionLocalDatasourceImpl(this._databaseService);

  @override
  Future<Result<int>> createQueuedAction(QueuedActionModel queue) async {
    try {
      await _databaseService.database.insert(
        DatabaseConfig.queuedActionTableName,
        queue.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // The id has been generated in models
      return Result.success(data: queue.id);
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<void>> deleteQueuedAction(int id) async {
    try {
      await _databaseService.database.delete(
        DatabaseConfig.queuedActionTableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      return Result.success(data: null);
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<QueuedActionModel?>> getQueuedAction(int id) async {
    try {
      var res = await _databaseService.database.query(
        DatabaseConfig.queuedActionTableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (res.isEmpty) return Result.success(data: null);

      return Result.success(data: QueuedActionModel.fromJson(res.first));
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<List<QueuedActionModel>>> getAllUserQueuedAction() async {
    try {
      var res = await _databaseService.database.query(
        DatabaseConfig.queuedActionTableName,
      );

      return Result.success(
        data: res.map((e) => QueuedActionModel.fromJson(e)).toList(),
      );
    } catch (e) {
      return Result.failure(error: e);
    }
  }
}
