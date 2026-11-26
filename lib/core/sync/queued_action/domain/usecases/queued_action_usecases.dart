import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/sync/queued_action/domain/export.dart';

class GetAllQueuedActionUsecase extends Usecase<Result, NoParam> {
  GetAllQueuedActionUsecase(this._queuedActionRepository);

  final QueuedActionRepository _queuedActionRepository;

  @override
  Future<Result<List<QueuedActionEntity>>> call(NoParam params) async => _queuedActionRepository.getAllQueuedAction();
}

class ExecuteAllQueuedActionUsecase extends Usecase<Result, List<QueuedActionEntity>> {
  ExecuteAllQueuedActionUsecase(this._queuedActionRepository);

  final QueuedActionRepository _queuedActionRepository;

  @override
  Future<Result<List<bool>>> call(List<QueuedActionEntity> params) async =>
      _queuedActionRepository.executeAllQueuedActions(params);
}
