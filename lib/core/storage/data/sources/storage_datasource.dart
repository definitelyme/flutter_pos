import 'package:flutter_pos/core/domain/export.dart';

abstract class StorageDataSource {
  Future<Result<String>> uploadUserPhoto(String imgPath);

  Future<Result<String?>> uploadProductImage(String imgPath);
}
