import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/storage/domain/export.dart';
import 'package:flutter_pos/features/auth/presentation/export.dart';
import 'package:flutter_pos/features/products/domain/export.dart';
import 'package:flutter_pos/features/products/presentation/export.dart';
import 'package:flutter_pos/managers/export.dart';
import 'package:flutter_pos/utils/utils.dart';

final productFormNotifierProvider = NotifierProvider.autoDispose<ProductFormNotifier, ProductFormState>(
  ProductFormNotifier.new,
);

class ProductFormNotifier extends AutoDisposeNotifier<ProductFormState> {
  GetProductUsecase get _getProduct => getIt();
  UploadProductImageUsecase get _uploadProductImage => getIt();
  CreateProductUsecase get _createProduct => getIt();
  UpdateProductUsecase get _updateProduct => getIt();
  DeleteProductUsecase get _deleteProduct => getIt();

  @override
  ProductFormState build() {
    return const ProductFormState();
  }

  String _requireUserId() {
    final authState = ref.read(authNotifierProvider);
    if (authState.isAuthenticated) return authState.user!.id;
    throw 'Unauthenticated!';
  }

  Future<void> initProductForm(int? productId) async {
    if (productId == null) {
      state = state.copyWith(isLoaded: true);
      return;
    }

    var res = await _getProduct.execute(productId);

    if (res.isSuccess) {
      var product = res.data;

      state = state.copyWith(
        imageUrl: product?.imageUrl,
        name: product?.name,
        price: product?.price,
        stock: product?.stock,
        description: product?.description,
        isLoaded: true,
      );
    } else {
      throw res.error ?? 'Failed to load data';
    }
  }

  Future<Result<int>> createProduct() async {
    try {
      final userId = _requireUserId();

      var imageUrl = state.imageUrl;

      if (state.imageFile != null) {
        final res = await _uploadProductImage.execute(state.imageFile!.path);
        imageUrl = res.data;
      }

      cl('imageUrl $imageUrl');

      var product = ProductEntity(
        createdById: userId,
        name: state.name ?? '',
        imageUrl: imageUrl ?? '',
        stock: state.stock ?? 0,
        price: state.price ?? 0,
        description: state.description ?? '',
      );

      var res = await _createProduct.execute(product);

      // Refresh products
      unawaited(ref.read(productsNotifierProvider.notifier).getAllProducts());

      return res;
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  Future<Result<void>> updatedProduct(int id) async {
    try {
      final userId = _requireUserId();

      var imageUrl = state.imageUrl;

      if (state.imageFile != null) {
        final res = await _uploadProductImage.execute(state.imageFile!.path);
        imageUrl = res.data;
      }

      cl('imageUrl $imageUrl');

      var product = ProductEntity(
        id: id,
        createdById: userId,
        name: state.name!,
        imageUrl: imageUrl ?? '',
        stock: state.stock ?? 0,
        price: state.price ?? 0,
        description: state.description ?? '',
      );

      var res = await _updateProduct.execute(product);

      // Refresh products
      unawaited(ref.read(productsNotifierProvider.notifier).getAllProducts());

      return res;
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  Future<Result<void>> deleteProduct(int id) async {
    try {
      var res = await _deleteProduct.execute(id);

      // Refresh products
      unawaited(ref.read(productsNotifierProvider.notifier).getAllProducts());

      return res;
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  void onChangedImage(File value) {
    state = state.copyWith(imageFile: value);
  }

  void onChangedName(String value) {
    state = state.copyWith(name: value);
  }

  void onChangedPrice(String value) {
    state = state.copyWith(price: int.tryParse(value));
  }

  void onChangedStock(String value) {
    state = state.copyWith(stock: int.tryParse(value));
  }

  void onChangedDesc(String value) {
    state = state.copyWith(description: value);
  }
}
