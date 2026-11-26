import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';

@injectable
class CreateProductUsecase extends UseCase<Result, ProductEntity> {
  CreateProductUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Result<int>> execute(ProductEntity params) async => _productRepository.createProduct(params);
}
