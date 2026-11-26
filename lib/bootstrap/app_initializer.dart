import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_pos/config/export.dart';
import 'package:flutter_pos/managers/export.dart';

Future<void> bootstrapApp() async {
  // Initialize binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the default Firebase app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Use the local Firebase emulators in debug builds
  if (kDebugMode) {
    FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, firestoreEmulatorPort);
    await FirebaseAuth.instance.useAuthEmulator(emulatorHost, authEmulatorPort);
    await FirebaseStorage.instance.useStorageEmulator(emulatorHost, storageEmulatorPort);
  }

  // Ensure persistence is cleared
  await FirebaseFirestore.instance.clearPersistence();

  // Turn off Crashlytics collection in debug builds
  if (kDebugMode) await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);

  // Register dependencies (this also opens the app local db and shared preferences)
  await setupRegistry();

  // Initialize date formatting
  await initializeDateFormatting();

  // Set/lock screen orientation
  await SystemChrome.setPreferredOrientations([]);

  // Set Default SystemUIOverlayStyle
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
}
