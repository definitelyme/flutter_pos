import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/products/data/export.dart';

abstract class ProductDatasource {
  Future<Result<int>> createProduct(ProductModel product);

  Future<Result<void>> updateProduct(ProductModel product);

  Future<Result<void>> deleteProduct(int id);

  Future<Result<ProductModel?>> getProduct(int id);

  Future<Result<List<ProductModel>>> getAllUserProducts(String userId);

  Future<Result<List<ProductModel>>> getUserProducts(
    String userId, {
    String orderBy,
    String sortBy,
    int limit,
    int? offset,
    String? contains,
  });
}
