import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/sync/queued_action/data/export.dart';

abstract class QueuedActionDatasource {
  Future<Result<int>> createQueuedAction(QueuedActionModel queue);

  Future<Result<QueuedActionModel?>> getQueuedAction(int id);

  Future<Result<List<QueuedActionModel>>> getAllUserQueuedAction();

  Future<Result<void>> deleteQueuedAction(int id);
}
