import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

// Third parties
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => getIt<FirebaseFirestore>());
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) => getIt<FirebaseStorage>());
final firebaseCrashlyticsProvider = Provider<FirebaseCrashlytics>((ref) => getIt<FirebaseCrashlytics>());
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => getIt<FirebaseAuth>());
final googleSignInProvider = Provider<GoogleSignIn>((ref) => getIt<GoogleSignIn>());
final deviceInfoPluginProvider = Provider<DeviceInfoPlugin>((ref) => getIt<DeviceInfoPlugin>());

// Routes
final appRoutesProvider = Provider<AppRoutes>((ref) => AppRoutes(ref));

// Services
final databaseServiceProvider = Provider<DatabaseService>((ref) => getIt<DatabaseService>());
final pingServiceProvider = Provider<PingService>((ref) => getIt<PingService>());
final deviceInfoServiceProvider = Provider<DeviceInfoService>((ref) => getIt<DeviceInfoService>());
final errorLoggerServiceProvider = Provider<ErrorLoggerService>((ref) => getIt<ErrorLoggerService>());
final printerServiceProvider = Provider<PrinterService>((ref) => getIt<PrinterService>());

// Datasources
// Local Datasources
final productLocalDatasourceProvider = Provider<ProductLocalDatasource>((ref) => getIt<ProductLocalDatasource>());
final transactionLocalDatasourceProvider = Provider<TransactionLocalDatasource>(
  (ref) => getIt<TransactionLocalDatasource>(),
);
final userLocalDatasourceProvider = Provider<UserLocalDatasource>((ref) => getIt<UserLocalDatasource>());
final queuedActionLocalDatasourceProvider = Provider<QueuedActionDatasource>((ref) => getIt<QueuedActionDatasource>());

// Remote Datasources
final authRemoteDataSourceProvider = Provider<AuthDataSource>((ref) => getIt<AuthDataSource>());
final storageRemoteDataSourceProvider = Provider<StorageDataSource>((ref) => getIt<StorageDataSource>());
final productRemoteDatasourceProvider = Provider<ProductRemoteDatasource>((ref) => getIt<ProductRemoteDatasource>());
final transactionRemoteDatasourceProvider = Provider<TransactionRemoteDatasource>(
  (ref) => getIt<TransactionRemoteDatasource>(),
);
final userRemoteDatasourceProvider = Provider<UserRemoteDatasource>((ref) => getIt<UserRemoteDatasource>());

// Repositories
final authRepositoryProvider = Provider<AuthRepository>((ref) => getIt<AuthRepository>());
final storageRepositoryProvider = Provider<StorageRepository>((ref) => getIt<StorageRepository>());
final productRepositoryProvider = Provider<ProductRepository>((ref) => getIt<ProductRepository>());
final transactionRepositoryProvider = Provider<TransactionRepository>((ref) => getIt<TransactionRepository>());
final userRepositoryProvider = Provider<UserRepository>((ref) => getIt<UserRepository>());
final queuedActionRepositoryProvider = Provider<QueuedActionRepository>((ref) => getIt<QueuedActionRepository>());
