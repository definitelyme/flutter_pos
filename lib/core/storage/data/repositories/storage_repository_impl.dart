import 'package:flutter_pos/core/data/export.dart';
import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/storage/data/export.dart';
import 'package:flutter_pos/core/storage/domain/export.dart';

class StorageRepositoryImpl implements StorageRepository {
  final PingService pingService;
  final StorageRemoteDataSourceImpl storageRemoteDataSource;

  StorageRepositoryImpl({
    required this.pingService,
    required this.storageRemoteDataSource,
  });

  @override
  Future<Result<String>> uploadUserPhoto(String imgPath) async {
    try {
      if (!pingService.isConnected) {
        return Result.failure(error: 'Please check your internet connection and try again');
      }

      final res = await storageRemoteDataSource.uploadUserPhoto(imgPath);
      if (res.isFailure) return Result.failure(error: res.error!);

      return Result.success(data: res.data!);
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  @override
  Future<Result<String>> uploadProductImage(String imgPath) async {
    try {
      if (!pingService.isConnected) {
        return Result.failure(error: 'Please check your internet connection and try again');
      }

      final res = await storageRemoteDataSource.uploadProductImage(imgPath);
      if (res.isFailure) return Result.failure(error: res.error!);

      return Result.success(data: res.data!);
    } catch (e) {
      return Result.failure(error: e);
    }
  }
}
