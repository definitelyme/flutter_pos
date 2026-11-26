import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';

@injectable
class UpdateProductUsecase extends UseCase<Result<void>, ProductEntity> {
  UpdateProductUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Result<void>> execute(ProductEntity params) async => _productRepository.updateProduct(params);
}
