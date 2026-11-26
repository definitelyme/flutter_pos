import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_pos/managers/registry/registry.config.dart';

final GetIt getIt = GetIt.I;

/// Registers every injectable class and module with [getIt].
@InjectableInit(preferRelativeImports: false, asExtension: true, throwOnMissingDependencies: true)
Future<void> setupRegistry() => getIt.init();
