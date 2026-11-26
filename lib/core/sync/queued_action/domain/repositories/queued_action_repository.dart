import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/sync/queued_action/domain/export.dart';

abstract class QueuedActionRepository {
  Future<Result<List<QueuedActionEntity>>> getAllQueuedAction();
  Future<Result<List<bool>>> executeAllQueuedActions(List<QueuedActionEntity> queues);
  Future<Result<bool>> executeQueuedAction(QueuedActionEntity queue);
}
