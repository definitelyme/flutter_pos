import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_pos/core/domain/export.dart';
import 'package:flutter_pos/core/storage/data/export.dart';

@LazySingleton(as: StorageDataSource)
class StorageRemoteDataSourceImpl implements StorageDataSource {
  final FirebaseStorage _firebaseStorage;

  StorageRemoteDataSourceImpl(this._firebaseStorage);

  @override
  Future<Result<String>> uploadUserPhoto(String imgPath) async {
    final ref = _firebaseStorage
        .ref()
        .child('user_photos')
        .child('UserImage_${DateTime.now().millisecondsSinceEpoch}.jpg');

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    final taskSnapshot = await ref.putFile(File(imgPath), metadata);

    final url = await taskSnapshot.ref.getDownloadURL();

    return Result.success(data: url);
  }

  @override
  Future<Result<String>> uploadProductImage(String imgPath) async {
    final ref = _firebaseStorage
        .ref()
        .child('products')
        .child('ProductImage_${DateTime.now().millisecondsSinceEpoch}.jpg');

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    final taskSnapshot = await ref.putFile(File(imgPath), metadata);

    final url = await taskSnapshot.ref.getDownloadURL();

    return Result.success(data: url);
  }
}
