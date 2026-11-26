import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';

@injectable
class GetProductUsecase extends UseCase<Result, int> {
  GetProductUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Result<ProductEntity?>> execute(int params) async => _productRepository.getProduct(params);
}
