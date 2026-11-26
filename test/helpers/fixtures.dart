import 'package:flutter_pos/features/account/data/export.dart';
import 'package:flutter_pos/features/products/data/export.dart';
import 'package:flutter_pos/features/transactions/data/export.dart';

const _userId = 'user123';

ProductModel createSampleProduct({int id = 1}) {
  return ProductModel(
    id: id,
    name: 'Sample Product',
    createdById: _userId,
    imageUrl: '',
    price: 42,
    sold: 10,
    stock: 50,
  );
}

UserModel createSampleUser({
  String id = 'user123',
  String name = 'Sample User',
  String imageUrl = '',
}) {
  return UserModel(
    id: id,
    name: name,
    imageUrl: imageUrl,
  );
}

TransactionModel createSampleTransaction({
  int id = 1,
  String createdById = _userId,
  int totalAmount = 1,
}) {
  return TransactionModel(
    id: id,
    createdById: createdById,
    paymentMethod: 'Cash',
    receivedAmount: totalAmount,
    returnAmount: 0,
    totalAmount: totalAmount,
    totalOrderedProduct: 1,
    orderedProducts: [
      OrderedProductModel(
        id: 1,
        transactionId: id,
        productId: 1,
        quantity: 1,
        stock: 1,
        name: 'Sample Product',
        imageUrl: '',
        price: totalAmount,
      ),
    ],
  );
}
