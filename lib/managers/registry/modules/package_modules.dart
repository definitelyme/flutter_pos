part of 'modules.dart';

@module
abstract class PackageModule {
  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn.instance;

  @lazySingleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  /// Opens the local database before anything that reads it is resolved.
  @preResolve
  @singleton
  Future<DatabaseService> get databaseService async {
    await DatabaseService.instance.init();
    return DatabaseService.instance;
  }
}
