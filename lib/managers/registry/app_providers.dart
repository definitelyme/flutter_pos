import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_pos/core/data/export.dart';
import 'package:flutter_pos/core/storage/data/export.dart';
import 'package:flutter_pos/core/storage/domain/export.dart';
import 'package:flutter_pos/core/sync/queued_action/data/export.dart';
import 'package:flutter_pos/core/sync/queued_action/domain/export.dart';
import 'package:flutter_pos/features/account/data/export.dart';
import 'package:flutter_pos/features/account/domain/export.dart';
import 'package:flutter_pos/features/auth/data/export.dart';
import 'package:flutter_pos/features/auth/domain/export.dart';
import 'package:flutter_pos/features/products/data/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';
import 'package:flutter_pos/features/transactions/data/export.dart';
import 'package:flutter_pos/features/transactions/domain/export.dart';
import 'package:flutter_pos/managers/export.dart';

// Startup overrides
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPreferencesProvider must be overridden at app startup.'),
);

// Third parties
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);
final firebaseCrashlyticsProvider = Provider<FirebaseCrashlytics>((ref) => FirebaseCrashlytics.instance);
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final googleSignInProvider = Provider<GoogleSignIn>((ref) => GoogleSignIn.instance);
final deviceInfoPluginProvider = Provider<DeviceInfoPlugin>((ref) => DeviceInfoPlugin());

// Routes
final appRoutesProvider = Provider<AppRoutes>((ref) => AppRoutes(ref));

// Services
final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService.instance);
final pingServiceProvider = Provider<PingService>((ref) => PingService());
final deviceInfoServiceProvider = Provider<DeviceInfoService>(
  (ref) => DeviceInfoService(ref.watch(deviceInfoPluginProvider)),
);
final errorLoggerServiceProvider = Provider<ErrorLoggerService>(
  (ref) => ErrorLoggerService(ref.watch(firebaseCrashlyticsProvider)),
);
final printerServiceProvider = Provider<PrinterService>(
  (ref) => PrinterService(ref.watch(sharedPreferencesProvider)),
);

// Datasources
// Local Datasources
final productLocalDatasourceProvider = Provider<ProductLocalDatasourceImpl>(
  (ref) => ProductLocalDatasourceImpl(ref.watch(databaseServiceProvider)),
);
final transactionLocalDatasourceProvider = Provider<TransactionLocalDatasourceImpl>(
  (ref) => TransactionLocalDatasourceImpl(ref.watch(databaseServiceProvider)),
);
final userLocalDatasourceProvider = Provider<UserLocalDatasourceImpl>(
  (ref) => UserLocalDatasourceImpl(ref.watch(databaseServiceProvider)),
);
final queuedActionLocalDatasourceProvider = Provider<QueuedActionLocalDatasourceImpl>(
  (ref) => QueuedActionLocalDatasourceImpl(ref.watch(databaseServiceProvider)),
);

// Remote Datasources
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSourceImpl>(
  (ref) => AuthRemoteDataSourceImpl(
    firebaseAuth: ref.watch(firebaseAuthProvider),
    googleSignIn: ref.watch(googleSignInProvider),
  ),
);
final storageRemoteDataSourceProvider = Provider<StorageRemoteDataSourceImpl>(
  (ref) => StorageRemoteDataSourceImpl(ref.watch(firebaseStorageProvider)),
);
final productRemoteDatasourceProvider = Provider<ProductRemoteDatasourceImpl>(
  (ref) => ProductRemoteDatasourceImpl(ref.watch(firebaseFirestoreProvider)),
);
final transactionRemoteDatasourceProvider = Provider<TransactionRemoteDatasourceImpl>(
  (ref) => TransactionRemoteDatasourceImpl(ref.watch(firebaseFirestoreProvider)),
);
final userRemoteDatasourceProvider = Provider<UserRemoteDatasourceImpl>(
  (ref) => UserRemoteDatasourceImpl(ref.watch(firebaseFirestoreProvider)),
);

// Repositories
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    authRemoteDataSource: ref.watch(authRemoteDataSourceProvider),
  ),
);
final storageRepositoryProvider = Provider<StorageRepository>(
  (ref) => StorageRepositoryImpl(
    pingService: ref.watch(pingServiceProvider),
    storageRemoteDataSource: ref.watch(storageRemoteDataSourceProvider),
  ),
);
final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    pingService: ref.watch(pingServiceProvider),
    productLocalDatasource: ref.watch(productLocalDatasourceProvider),
    productRemoteDatasource: ref.watch(productRemoteDatasourceProvider),
    queuedActionLocalDatasource: ref.watch(queuedActionLocalDatasourceProvider),
  ),
);
final transactionRepositoryProvider = Provider<TransactionRepository>(
  (ref) => TransactionRepositoryImpl(
    pingService: ref.watch(pingServiceProvider),
    transactionLocalDatasource: ref.watch(transactionLocalDatasourceProvider),
    transactionRemoteDatasource: ref.watch(transactionRemoteDatasourceProvider),
    queuedActionLocalDatasource: ref.watch(queuedActionLocalDatasourceProvider),
  ),
);
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(
    pingService: ref.watch(pingServiceProvider),
    userLocalDatasource: ref.watch(userLocalDatasourceProvider),
    userRemoteDatasource: ref.watch(userRemoteDatasourceProvider),
    queuedActionLocalDatasource: ref.watch(queuedActionLocalDatasourceProvider),
  ),
);
final queuedActionRepositoryProvider = Provider<QueuedActionRepository>(
  (ref) => QueuedActionRepositoryImpl(
    pingService: ref.watch(pingServiceProvider),
    queuedActionLocalDatasource: ref.watch(queuedActionLocalDatasourceProvider),
    userRemoteDatasource: ref.watch(userRemoteDatasourceProvider),
    transactionRemoteDatasource: ref.watch(transactionRemoteDatasourceProvider),
    productRemoteDatasource: ref.watch(productRemoteDatasourceProvider),
  ),
);
