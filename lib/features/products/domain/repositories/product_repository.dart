import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';

abstract class ProductRepository {
  Future<Result<int>> syncAllUserProducts(String userId);

  Future<Result<ProductEntity?>> getProduct(int productId);

  Future<Result<int>> createProduct(ProductEntity product);

  Future<Result<void>> updateProduct(ProductEntity product);

  Future<Result<void>> deleteProduct(int productId);

  Future<Result<List<ProductEntity>>> getUserProducts(
    String userId, {
    String orderBy,
    String sortBy,
    int limit,
    int? offset,
    String? contains,
  });
}
