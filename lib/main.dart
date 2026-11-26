import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_pos/config/export.dart';
import 'package:flutter_pos/core/data/export.dart';
import 'package:flutter_pos/managers/export.dart';
import 'package:flutter_pos/root_app.dart';

void main() async {
  // Initialize binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (use `flutterfire configure` to generate the options)
  await Firebase.initializeApp(
    name: DefaultFirebaseOptions.currentPlatform.projectId,
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize app local db
  await DatabaseService.instance.init();

  // Ensure persistence is cleared
  await FirebaseFirestore.instance.clearPersistence();

  // Initialize date formatting
  await initializeDateFormatting();

  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Set/lock screen orientation
  await SystemChrome.setPreferredOrientations([]);

  // Set Default SystemUIOverlayStyle
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPreferences)],
      child: const App(),
    ),
  );
}
