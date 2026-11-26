import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';

@injectable
class SyncAllUserProductsUsecase extends UseCase<Result, String> {
  SyncAllUserProductsUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Result<int>> execute(String params) async => _productRepository.syncAllUserProducts(params);
}
