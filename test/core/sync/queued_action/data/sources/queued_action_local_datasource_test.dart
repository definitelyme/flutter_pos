import 'package:flutter_pos/core/data/export.dart';
import 'package:flutter_pos/core/sync/queued_action/data/export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/export.dart';

void main() {
  late DatabaseService appDatabase;
  late QueuedActionLocalDatasourceImpl datasource;

  setUpAll(() async {
    appDatabase = await setUpTestDatabase();

    datasource = QueuedActionLocalDatasourceImpl(appDatabase);
  });

  final queuedAction = QueuedActionModel(
    id: 1,
    isCritical: true,
    method: '',
    repository: '',
    param: '',
    createdAt: '',
  );

  group('QueuedActionLocalDatasourceImpl', () {
    // Test: createQueuedAction inserts the queued action into the database
    test('createQueuedAction inserts queued action into the database', () async {
      // Call the createQueuedAction method
      final res = await datasource.createQueuedAction(queuedAction);

      // Verify that the ID returned matches the queued action's ID
      expect(res.data, equals(queuedAction.id));
    });

    // Test: getQueuedAction retrieves the queued action from the database
    test('getQueuedAction retrieves queued action from the database', () async {
      final res = await datasource.getQueuedAction(queuedAction.id);

      // Verify that the retrieved queued action's ID matches the expected ID
      expect(res.data?.id, equals(queuedAction.id));
    });

    // Test: getAllUserQueuedAction retrieves all queued actions for a given user
    test('getAllUserQueuedAction retrieves all queued action from the database', () async {
      final res = await datasource.getAllUserQueuedAction();

      // Expect that the result is not empty
      expect(res.data, isNotEmpty);
    });

    // Test: deleteQueuedAction deletes the queued action from the database
    test('deleteQueuedAction deletes queued action from the database', () async {
      final deleteQueuedAction = await datasource.deleteQueuedAction(queuedAction.id);

      // Expect that the deletion completes successfully
      expect(deleteQueuedAction.isSuccess, true);
    });
  });
}
