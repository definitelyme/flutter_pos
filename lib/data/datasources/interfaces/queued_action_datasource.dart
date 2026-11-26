import 'package:flutter_pos/core/common/result.dart';
import 'package:flutter_pos/data/models/queued_action_model.dart';

abstract class QueuedActionDatasource {
  Future<Result<int>> createQueuedAction(QueuedActionModel queue);

  Future<Result<QueuedActionModel?>> getQueuedAction(int id);

  Future<Result<List<QueuedActionModel>>> getAllUserQueuedAction();

  Future<Result<void>> deleteQueuedAction(int id);
}
