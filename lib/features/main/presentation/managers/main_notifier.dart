import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/core/data/export.dart';
import 'package:flutter_pos/core/presentation/export.dart';
import 'package:flutter_pos/core/sync/queued_action/domain/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart' hide AuthProvider;
import 'package:flutter_pos/features/auth/presentation/export.dart';
import 'package:flutter_pos/features/main/presentation/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';
import 'package:flutter_pos/features/products/presentation/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';
import 'package:flutter_pos/managers/export.dart';

final mainNotifierProvider = NotifierProvider<MainNotifier, MainState>(
  MainNotifier.new,
);

class MainNotifier extends Notifier<MainState> {
  DeviceInfoService get _deviceInfoService => getIt();
  PingService get _pingService => getIt();
  GetUserUsecase get _getUser => getIt();
  SyncAllUserProductsUsecase get _syncAllUserProducts => getIt();
  SyncAllUserTransactionsUsecase get _syncAllUserTransactions => getIt();
  ExecuteAllQueuedActionUsecase get _executeAllQueuedAction => getIt();
  GetAllQueuedActionUsecase get _getAllQueuedAction => getIt();

  @override
  MainState build() {
    return const MainState();
  }

  String _requireUserId() {
    final authState = ref.read(authNotifierProvider);
    if (authState.isAuthenticated) return authState.user!.id;
    throw 'Unauthenticated!';
  }

  Future<void> initMainProvider() async {
    await startPingService();
    await getAndSyncAllUserData();
  }

  Future<void> startPingService() async {
    final deviceInfoService = _deviceInfoService;
    final pingService = _pingService;

    // Note: The ICMP protocol may not work on virtual devices
    final isPhysicalDevice = await deviceInfoService.checkDeviceType();

    unawaited(pingService.startPing(host: isPhysicalDevice ? '8.8.8.8' : '127.0.0.1'));
    pingService.addConnectionStatusListener(
      (isConnected) => onHasInternet(isConnected),
    );
  }

  Future<void> checkAndSyncAllData() async {
    final pingService = _pingService;

    // Prevent sync during first time app open
    if (!state.isLoaded || !pingService.isConnected) return;

    try {
      state = state.copyWith(isSyncronizing: true);

      // Execute all queued actions
      int queueExecutedCount = await executeAllQueuedActions();

      // Sync all data
      await getAndSyncAllUserData();

      if (queueExecutedCount > 0) {
        unawaited(AppSnackBar.show('$queueExecutedCount queues executed'));
      }

      // Re-check queued actions
      unawaited(checkIsHasQueuedActions());

      state = state.copyWith(isSyncronizing: false);
    } catch (e) {
      state = state.copyWith(isSyncronizing: false);
      unawaited(AppSnackBar.showError('Failed to sync data\n\n${e.toString()}'));
    }
  }

  Future<void> getAndSyncAllUserData() async {
    final userId = _requireUserId();

    // Run multiple futures simultaneously
    var res = await Future.wait([
      _getUser.execute(userId),
      _syncAllUserProducts.execute(userId),
      _syncAllUserTransactions.execute(userId),
    ]);

    // Set and notify user state
    if (res.first.isSuccess) {
      state = state.copyWith(user: res.first.data as UserEntity?);
    }

    if (res[1].isFailure) unawaited(AppSnackBar.showError('Failed to sync product data'));
    if (res[2].isFailure) unawaited(AppSnackBar.showError('Failed to sync transaction data'));

    // Refresh products list
    unawaited(ref.read(productsNotifierProvider.notifier).getAllProducts());

    // Check queued actions
    unawaited(checkIsHasQueuedActions());

    // Notify to MainScreen
    state = state.copyWith(isLoaded: true);
  }

  Future<int> executeAllQueuedActions() async {
    var queuedActions = await getQueuedActions();

    if (queuedActions.isNotEmpty) {
      var res = await _executeAllQueuedAction.execute(queuedActions);

      int executedCount = res.data?.where((e) => e).length ?? 0;
      return executedCount;
    }

    return 0;
  }

  Future<List<QueuedActionEntity>> getQueuedActions() async {
    var res = await _getAllQueuedAction.execute();
    return res.data ?? [];
  }

  Future<void> onHasInternet(bool value) async {
    state = state.copyWith(isHasInternet: value);
    if (value) unawaited(checkAndSyncAllData());
  }

  Future<void> checkIsHasQueuedActions() async {
    final isEmpty = (await getQueuedActions()).isEmpty;
    state = state.copyWith(isHasQueuedActions: isEmpty);
  }
}
