import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';

@injectable
class DeleteProductUsecase extends UseCase<Result<void>, int> {
  DeleteProductUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Result<void>> execute(int params) async => _productRepository.deleteProduct(params);
}
