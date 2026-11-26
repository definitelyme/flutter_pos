import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_pos/config/export.dart';
import 'package:flutter_pos/managers/export.dart';

Future<void> bootstrapApp() async {
  // Initialize binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (use `flutterfire configure` to generate the options)
  await Firebase.initializeApp(
    name: DefaultFirebaseOptions.currentPlatform.projectId,
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ensure persistence is cleared
  await FirebaseFirestore.instance.clearPersistence();

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
