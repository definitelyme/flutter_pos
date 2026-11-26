import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/storage/domain/export.dart';

@injectable
class UploadProductImageUsecase extends UseCase<Result, String> {
  UploadProductImageUsecase(this._storageRepository);

  final StorageRepository _storageRepository;

  @override
  Future<Result<String?>> execute(String imgPath) async => _storageRepository.uploadProductImage(imgPath);
}
