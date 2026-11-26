import 'package:flutter_pos/core/common/result.dart';

abstract class StorageDataSource {
  Future<Result<String>> uploadUserPhoto(String imgPath);

  Future<Result<String?>> uploadProductImage(String imgPath);
}
