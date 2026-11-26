import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/app/di/app_providers.dart';
import 'package:flutter_pos/core/common/result.dart';
import 'package:flutter_pos/domain/entities/ordered_product_entity.dart';
import 'package:flutter_pos/domain/entities/product_entity.dart';
import 'package:flutter_pos/domain/entities/transaction_entity.dart';
import 'package:flutter_pos/domain/usecases/transaction_usecases.dart';
import 'package:flutter_pos/presentation/providers/auth/auth_notifier.dart';
import 'package:flutter_pos/presentation/providers/products/products_notifier.dart';
import 'package:flutter_pos/presentation/providers/home/home_state.dart';

final homeNotifierProvider = NotifierProvider.autoDispose<HomeNotifier, HomeState>(
  HomeNotifier.new,
);

class HomeNotifier extends AutoDisposeNotifier<HomeState> {
  @override
  HomeState build() {
    return const HomeState();
  }

  Future<Result<int>> createTransaction() async {
    try {
      final authState = ref.read(authNotifierProvider);
      if (!authState.isAuthenticated) throw 'Unauthenticated!';
      final user = authState.user!;

      var transaction = TransactionEntity(
        id: DateTime.now().millisecondsSinceEpoch,
        paymentMethod: state.selectedPaymentMethod,
        customerName: state.customerName,
        description: state.description,
        orderedProducts: state.orderedProducts,
        createdById: user.id,
        createdBy: user,
        receivedAmount: state.receivedAmount,
        returnAmount: state.receivedAmount - getTotalAmount(),
        totalOrderedProduct: state.orderedProducts.length,
        totalAmount: getTotalAmount(),
      );

      final transactionRepository = ref.read(transactionRepositoryProvider);
      var res = await CreateTransactionUsecase(transactionRepository).call(transaction);

      if (res.isSuccess) {
        // Auto print receipt (fire-and-forget, ignore failure)
        unawaited(ref.read(printerServiceProvider).printTransaction(transaction));
      }

      // Refresh products
      unawaited(ref.read(productsNotifierProvider.notifier).getAllProducts());

      return res;
    } catch (e) {
      return Result.failure(error: e);
    }
  }

  void onChangedIsPanelExpanded(bool val) {
    state = state.copyWith(isPanelExpanded: val);
  }

  void onAddOrderedProduct(ProductEntity product, int qty) {
    final orderedProducts = [...state.orderedProducts];
    var currentIndex = orderedProducts.indexWhere((e) => e.productId == product.id);

    if (currentIndex != -1) {
      orderedProducts[currentIndex] = orderedProducts[currentIndex].copyWith(quantity: qty);
    } else {
      var order = OrderedProductEntity(
        id: DateTime.now().millisecondsSinceEpoch,
        productId: product.id!,
        quantity: qty,
        stock: product.stock,
        name: product.name,
        imageUrl: product.imageUrl,
        price: product.price,
      );

      orderedProducts.add(order);
    }

    state = state.copyWith(orderedProducts: orderedProducts);
  }

  void onRemoveOrderedProduct(OrderedProductEntity val) {
    state = state.copyWith(
      orderedProducts: state.orderedProducts.where((e) => e != val).toList(),
    );
  }

  void onRemoveAllOrderedProduct() {
    state = const HomeState();
  }

  void onChangedOrderedProductQuantity(int index, int value) {
    final orderedProducts = [...state.orderedProducts];
    orderedProducts[index] = orderedProducts[index].copyWith(quantity: value);
    state = state.copyWith(orderedProducts: orderedProducts);
  }

  void onChangedReceivedAmount(int value) {
    state = state.copyWith(receivedAmount: value);
  }

  void onChangedPaymentMethod(String? value) {
    state = state.copyWith(selectedPaymentMethod: value ?? state.selectedPaymentMethod);
  }

  void onChangedCustomerName(String value) {
    state = state.copyWith(customerName: value);
  }

  void onChangedDescription(String value) {
    state = state.copyWith(description: value);
  }

  int getTotalAmount() {
    if (state.orderedProducts.isEmpty) return 0;
    return state.orderedProducts.map((e) => e.price * e.quantity).reduce((a, b) => a + b);
  }
}
