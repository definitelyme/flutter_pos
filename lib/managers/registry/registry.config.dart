// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i141;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:flutter_pos/core/data/export.dart' as _i167;
import 'package:flutter_pos/core/data/services/connectivity/ping_service.dart'
    as _i311;
import 'package:flutter_pos/core/data/services/info/device_info_service.dart'
    as _i99;
import 'package:flutter_pos/core/data/services/logger/error_logger_service.dart'
    as _i462;
import 'package:flutter_pos/core/data/services/printer/printer_service.dart'
    as _i983;
import 'package:flutter_pos/core/storage/data/export.dart' as _i1067;
import 'package:flutter_pos/core/storage/data/repositories/storage_repository_impl.dart'
    as _i963;
import 'package:flutter_pos/core/storage/data/sources/storage_remote_datasource_impl.dart'
    as _i825;
import 'package:flutter_pos/core/storage/domain/export.dart' as _i641;
import 'package:flutter_pos/core/storage/domain/usecases/upload_product_image_usecase.dart'
    as _i1002;
import 'package:flutter_pos/core/storage/domain/usecases/upload_user_photo_usecase.dart'
    as _i26;
import 'package:flutter_pos/core/sync/queued_action/data/export.dart' as _i649;
import 'package:flutter_pos/core/sync/queued_action/data/repositories/queued_action_repository_impl.dart'
    as _i565;
import 'package:flutter_pos/core/sync/queued_action/data/sources/queued_action_local_datasource_impl.dart'
    as _i375;
import 'package:flutter_pos/core/sync/queued_action/domain/export.dart'
    as _i550;
import 'package:flutter_pos/core/sync/queued_action/domain/usecases/execute_all_queued_action_usecase.dart'
    as _i977;
import 'package:flutter_pos/core/sync/queued_action/domain/usecases/get_all_queued_action_usecase.dart'
    as _i1012;
import 'package:flutter_pos/features/account/data/export.dart' as _i526;
import 'package:flutter_pos/features/account/data/repositories/user_repository_impl.dart'
    as _i912;
import 'package:flutter_pos/features/account/data/sources/user_local_datasource_impl.dart'
    as _i1017;
import 'package:flutter_pos/features/account/data/sources/user_remote_datasource_impl.dart'
    as _i340;
import 'package:flutter_pos/features/account/domain/export.dart' as _i83;
import 'package:flutter_pos/features/account/domain/usecases/create_user_usecase.dart'
    as _i199;
import 'package:flutter_pos/features/account/domain/usecases/delete_user_usecase.dart'
    as _i479;
import 'package:flutter_pos/features/account/domain/usecases/get_user_usecase.dart'
    as _i267;
import 'package:flutter_pos/features/account/domain/usecases/upate_user_usecase.dart'
    as _i256;
import 'package:flutter_pos/features/auth/data/export.dart' as _i494;
import 'package:flutter_pos/features/auth/data/repositories/auth_repository_impl.dart'
    as _i458;
import 'package:flutter_pos/features/auth/data/sources/auth_remote_datasource_impl.dart'
    as _i675;
import 'package:flutter_pos/features/auth/domain/export.dart' as _i247;
import 'package:flutter_pos/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i129;
import 'package:flutter_pos/features/auth/domain/usecases/sign_in_with_google_usecase.dart'
    as _i814;
import 'package:flutter_pos/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i909;
import 'package:flutter_pos/features/products/data/export.dart' as _i152;
import 'package:flutter_pos/features/products/data/repositories/product_repository_impl.dart'
    as _i848;
import 'package:flutter_pos/features/products/data/sources/product_local_datasource_impl.dart'
    as _i490;
import 'package:flutter_pos/features/products/data/sources/product_remote_datasource_impl.dart'
    as _i829;
import 'package:flutter_pos/features/products/domain/export.dart' as _i60;
import 'package:flutter_pos/features/products/domain/usecases/create_product_usecase.dart'
    as _i138;
import 'package:flutter_pos/features/products/domain/usecases/delete_product_usecase.dart'
    as _i685;
import 'package:flutter_pos/features/products/domain/usecases/get_product_usecase.dart'
    as _i422;
import 'package:flutter_pos/features/products/domain/usecases/get_user_products_usecase.dart'
    as _i896;
import 'package:flutter_pos/features/products/domain/usecases/sync_all_user_products_usecase.dart'
    as _i369;
import 'package:flutter_pos/features/products/domain/usecases/update_product_usecase.dart'
    as _i478;
import 'package:flutter_pos/features/transactions/data/export.dart' as _i171;
import 'package:flutter_pos/features/transactions/data/repositories/transaction_repository_impl.dart'
    as _i172;
import 'package:flutter_pos/features/transactions/data/sources/transaction_local_datasource_impl.dart'
    as _i131;
import 'package:flutter_pos/features/transactions/data/sources/transaction_remote_datasource_impl.dart'
    as _i699;
import 'package:flutter_pos/features/transactions/domain/export.dart' as _i813;
import 'package:flutter_pos/features/transactions/domain/usecases/create_transaction_usecase.dart'
    as _i109;
import 'package:flutter_pos/features/transactions/domain/usecases/delete_transaction_usecase.dart'
    as _i301;
import 'package:flutter_pos/features/transactions/domain/usecases/get_transaction_usecase.dart'
    as _i373;
import 'package:flutter_pos/features/transactions/domain/usecases/get_user_transactions_usecase.dart'
    as _i889;
import 'package:flutter_pos/features/transactions/domain/usecases/sync_all_user_transactions_usecase.dart'
    as _i1007;
import 'package:flutter_pos/features/transactions/domain/usecases/upate_transaction_usecase.dart'
    as _i353;
import 'package:flutter_pos/managers/registry/modules/modules.dart' as _i505;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final packageModule = _$PackageModule();
    final firebaseModule = _$FirebaseModule();
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => packageModule.sharedPreferences,
      preResolve: true,
    );
    await gh.singletonAsync<_i167.DatabaseService>(
      () => packageModule.databaseService,
      preResolve: true,
    );
    gh.lazySingleton<_i311.PingService>(() => _i311.PingService());
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestore,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i457.FirebaseStorage>(
      () => firebaseModule.firebaseStorage,
    );
    gh.lazySingleton<_i141.FirebaseCrashlytics>(
      () => firebaseModule.firebaseCrashlytics,
    );
    gh.lazySingleton<_i116.GoogleSignIn>(() => packageModule.googleSignIn);
    gh.lazySingleton<_i833.DeviceInfoPlugin>(
      () => packageModule.deviceInfoPlugin,
    );
    gh.lazySingleton<_i494.AuthDataSource>(
      () => _i675.AuthRemoteDataSourceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i526.UserRemoteDatasource>(
      () => _i340.UserRemoteDatasourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i462.ErrorLoggerService>(
      () => _i462.ErrorLoggerService(gh<_i141.FirebaseCrashlytics>()),
    );
    gh.lazySingleton<_i99.DeviceInfoService>(
      () => _i99.DeviceInfoService(gh<_i833.DeviceInfoPlugin>()),
    );
    gh.lazySingleton<_i171.TransactionRemoteDatasource>(
      () =>
          _i699.TransactionRemoteDatasourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i152.ProductRemoteDatasource>(
      () => _i829.ProductRemoteDatasourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i649.QueuedActionDatasource>(
      () => _i375.QueuedActionLocalDatasourceImpl(gh<_i167.DatabaseService>()),
    );
    gh.lazySingleton<_i152.ProductLocalDatasource>(
      () => _i490.ProductLocalDatasourceImpl(gh<_i167.DatabaseService>()),
    );
    gh.lazySingleton<_i1067.StorageDataSource>(
      () => _i825.StorageRemoteDataSourceImpl(gh<_i457.FirebaseStorage>()),
    );
    gh.lazySingleton<_i247.AuthRepository>(
      () => _i458.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i494.AuthDataSource>(),
      ),
    );
    gh.lazySingleton<_i983.PrinterService>(
      () => _i983.PrinterService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i526.UserLocalDatasource>(
      () => _i1017.UserLocalDatasourceImpl(gh<_i167.DatabaseService>()),
    );
    gh.lazySingleton<_i171.TransactionLocalDatasource>(
      () => _i131.TransactionLocalDatasourceImpl(gh<_i167.DatabaseService>()),
    );
    gh.lazySingleton<_i813.TransactionRepository>(
      () => _i172.TransactionRepositoryImpl(
        pingService: gh<_i167.PingService>(),
        transactionLocalDatasource: gh<_i171.TransactionLocalDatasource>(),
        transactionRemoteDatasource: gh<_i171.TransactionRemoteDatasource>(),
        queuedActionLocalDatasource: gh<_i649.QueuedActionDatasource>(),
      ),
    );
    gh.factory<_i129.GetCurrentUserUsecase>(
      () => _i129.GetCurrentUserUsecase(gh<_i247.AuthRepository>()),
    );
    gh.factory<_i814.SignInWithGoogleUsecase>(
      () => _i814.SignInWithGoogleUsecase(gh<_i247.AuthRepository>()),
    );
    gh.factory<_i909.SignOutUsecase>(
      () => _i909.SignOutUsecase(gh<_i247.AuthRepository>()),
    );
    gh.lazySingleton<_i83.UserRepository>(
      () => _i912.UserRepositoryImpl(
        pingService: gh<_i167.PingService>(),
        userLocalDatasource: gh<_i526.UserLocalDatasource>(),
        userRemoteDatasource: gh<_i526.UserRemoteDatasource>(),
        queuedActionLocalDatasource: gh<_i649.QueuedActionDatasource>(),
      ),
    );
    gh.factory<_i199.CreateUserUsecase>(
      () => _i199.CreateUserUsecase(gh<_i83.UserRepository>()),
    );
    gh.factory<_i479.DeleteUserUsecase>(
      () => _i479.DeleteUserUsecase(gh<_i83.UserRepository>()),
    );
    gh.factory<_i267.GetUserUsecase>(
      () => _i267.GetUserUsecase(gh<_i83.UserRepository>()),
    );
    gh.factory<_i256.UpateUserUsecase>(
      () => _i256.UpateUserUsecase(gh<_i83.UserRepository>()),
    );
    gh.lazySingleton<_i550.QueuedActionRepository>(
      () => _i565.QueuedActionRepositoryImpl(
        pingService: gh<_i167.PingService>(),
        queuedActionLocalDatasource: gh<_i649.QueuedActionDatasource>(),
        userRemoteDatasource: gh<_i526.UserRemoteDatasource>(),
        transactionRemoteDatasource: gh<_i171.TransactionRemoteDatasource>(),
        productRemoteDatasource: gh<_i152.ProductRemoteDatasource>(),
      ),
    );
    gh.factory<_i977.ExecuteAllQueuedActionUsecase>(
      () => _i977.ExecuteAllQueuedActionUsecase(
        gh<_i550.QueuedActionRepository>(),
      ),
    );
    gh.factory<_i1012.GetAllQueuedActionUsecase>(
      () =>
          _i1012.GetAllQueuedActionUsecase(gh<_i550.QueuedActionRepository>()),
    );
    gh.factory<_i109.CreateTransactionUsecase>(
      () => _i109.CreateTransactionUsecase(gh<_i813.TransactionRepository>()),
    );
    gh.factory<_i301.DeleteTransactionUsecase>(
      () => _i301.DeleteTransactionUsecase(gh<_i813.TransactionRepository>()),
    );
    gh.factory<_i373.GetTransactionUsecase>(
      () => _i373.GetTransactionUsecase(gh<_i813.TransactionRepository>()),
    );
    gh.factory<_i889.GetUserTransactionsUsecase>(
      () => _i889.GetUserTransactionsUsecase(gh<_i813.TransactionRepository>()),
    );
    gh.factory<_i1007.SyncAllUserTransactionsUsecase>(
      () => _i1007.SyncAllUserTransactionsUsecase(
        gh<_i813.TransactionRepository>(),
      ),
    );
    gh.factory<_i353.UpateTransactionUsecase>(
      () => _i353.UpateTransactionUsecase(gh<_i813.TransactionRepository>()),
    );
    gh.lazySingleton<_i60.ProductRepository>(
      () => _i848.ProductRepositoryImpl(
        pingService: gh<_i167.PingService>(),
        productLocalDatasource: gh<_i152.ProductLocalDatasource>(),
        productRemoteDatasource: gh<_i152.ProductRemoteDatasource>(),
        queuedActionLocalDatasource: gh<_i649.QueuedActionDatasource>(),
      ),
    );
    gh.lazySingleton<_i641.StorageRepository>(
      () => _i963.StorageRepositoryImpl(
        pingService: gh<_i167.PingService>(),
        storageRemoteDataSource: gh<_i1067.StorageDataSource>(),
      ),
    );
    gh.factory<_i138.CreateProductUsecase>(
      () => _i138.CreateProductUsecase(gh<_i60.ProductRepository>()),
    );
    gh.factory<_i685.DeleteProductUsecase>(
      () => _i685.DeleteProductUsecase(gh<_i60.ProductRepository>()),
    );
    gh.factory<_i422.GetProductUsecase>(
      () => _i422.GetProductUsecase(gh<_i60.ProductRepository>()),
    );
    gh.factory<_i896.GetUserProductsUsecase>(
      () => _i896.GetUserProductsUsecase(gh<_i60.ProductRepository>()),
    );
    gh.factory<_i369.SyncAllUserProductsUsecase>(
      () => _i369.SyncAllUserProductsUsecase(gh<_i60.ProductRepository>()),
    );
    gh.factory<_i478.UpdateProductUsecase>(
      () => _i478.UpdateProductUsecase(gh<_i60.ProductRepository>()),
    );
    gh.factory<_i1002.UploadProductImageUsecase>(
      () => _i1002.UploadProductImageUsecase(gh<_i641.StorageRepository>()),
    );
    gh.factory<_i26.UploadUserPhotoUsecase>(
      () => _i26.UploadUserPhotoUsecase(gh<_i641.StorageRepository>()),
    );
    return this;
  }
}

class _$PackageModule extends _i505.PackageModule {}

class _$FirebaseModule extends _i505.FirebaseModule {}
