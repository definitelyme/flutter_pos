import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/sync/queued_action/domain/export.dart';

@injectable
class ExecuteAllQueuedActionUsecase extends UseCase<Result, List<QueuedActionEntity>> {
  ExecuteAllQueuedActionUsecase(this._queuedActionRepository);

  final QueuedActionRepository _queuedActionRepository;

  @override
  Future<Result<List<bool>>> execute(List<QueuedActionEntity> params) async =>
      _queuedActionRepository.executeAllQueuedActions(params);
}
