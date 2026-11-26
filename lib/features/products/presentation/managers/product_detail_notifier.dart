import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/features/products/domain/export.dart';
import 'package:flutter_pos/managers/export.dart';

final productDetailNotifierProvider = NotifierProvider.autoDispose<ProductDetailNotifier, ProductEntity?>(
  ProductDetailNotifier.new,
);

class ProductDetailNotifier extends AutoDisposeNotifier<ProductEntity?> {
  GetProductUsecase get _getProduct => getIt();

  @override
  ProductEntity? build() {
    return null;
  }

  Future<ProductEntity?> getProductDetail(int id) async {
    var res = await _getProduct.execute(id);

    if (res.isSuccess) {
      state = res.data;
      return res.data;
    } else {
      throw res.error ?? 'Failed to load data';
    }
  }
}
