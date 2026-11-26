import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/sync/queued_action/domain/export.dart';

@injectable
class GetAllQueuedActionUsecase extends OpenUseCase<Result> {
  GetAllQueuedActionUsecase(this._queuedActionRepository);

  final QueuedActionRepository _queuedActionRepository;

  @override
  Future<Result<List<QueuedActionEntity>>> execute() async => _queuedActionRepository.getAllQueuedAction();
}
