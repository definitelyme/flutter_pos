import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/features/products/domain/export.dart';
import 'package:flutter_pos/managers/export.dart';

final productDetailNotifierProvider = NotifierProvider.autoDispose<ProductDetailNotifier, ProductEntity?>(
  ProductDetailNotifier.new,
);

class ProductDetailNotifier extends AutoDisposeNotifier<ProductEntity?> {
  @override
  ProductEntity? build() {
    return null;
  }

  Future<ProductEntity?> getProductDetail(int id) async {
    final productRepository = ref.read(productRepositoryProvider);
    var res = await GetProductUsecase(productRepository).call(id);

    if (res.isSuccess) {
      state = res.data;
      return res.data;
    } else {
      throw res.error ?? 'Failed to load data';
    }
  }
}
