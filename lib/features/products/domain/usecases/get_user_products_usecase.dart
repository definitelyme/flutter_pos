import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';

@injectable
class GetUserProductsUsecase extends UseCase<Result, BaseParams> {
  GetUserProductsUsecase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Result<List<ProductEntity>>> execute(BaseParams params) async => _productRepository.getUserProducts(
    params.param,
    orderBy: params.orderBy,
    sortBy: params.sortBy,
    limit: params.limit,
    offset: params.offset,
    contains: params.contains,
  );
}
