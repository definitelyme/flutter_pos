import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/storage/domain/export.dart';

class UploadUserPhotoUsecase extends Usecase<Result, String> {
  UploadUserPhotoUsecase(this._storageRepository);

  final StorageRepository _storageRepository;

  @override
  Future<Result<String?>> call(String imgPath) async => _storageRepository.uploadUserPhoto(imgPath);
}

class UploadProductImageUsecase extends Usecase<Result, String> {
  UploadProductImageUsecase(this._storageRepository);

  final StorageRepository _storageRepository;

  @override
  Future<Result<String?>> call(String imgPath) async => _storageRepository.uploadProductImage(imgPath);
}
