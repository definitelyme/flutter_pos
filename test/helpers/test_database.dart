import 'package:flutter_pos/core/data/export.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Opens an in-memory SQLite database through FFI and hands it to the
/// [DatabaseService] singleton, so local datasource tests can run on the host.
Future<DatabaseService> setUpTestDatabase() async {
  // Initialize FFI (Foreign Function Interface) for SQFlite
  sqfliteFfiInit();
  // Change the default factory for unit testing calls to use FFI
  databaseFactory = databaseFactoryFfi;

  // Open an in-memory database for testing
  final testDatabase = await openDatabase(inMemoryDatabasePath, version: 1);

  final appDatabase = DatabaseService.instance;
  await appDatabase.initTestDatabase(testDatabase: testDatabase);

  return appDatabase;
}
