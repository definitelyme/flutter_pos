import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }

    throw UnsupportedError('DefaultFirebaseOptions supports Android only.');
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:android:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'demo-flutter-pos',
    storageBucket: 'demo-flutter-pos.appspot.com',
  );

  static FirebaseOptions get ios => throw UnsupportedError('DefaultFirebaseOptions supports Android only.');
}
