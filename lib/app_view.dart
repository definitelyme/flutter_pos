import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/core/locale/export.dart';
import 'package:flutter_pos/core/presentation/export.dart';
import 'package:flutter_pos/managers/export.dart';

class AppView extends ConsumerWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider.select((s) => s.themeData));
    final router = ref.watch(appRoutesProvider).router;

    return MaterialApp.router(
      title: 'Flutter POS',
      theme: theme,
      debugShowCheckedModeBanner: kDebugMode,
      routerConfig: router,
      locale: AppLocale.defaultLocale,
      supportedLocales: AppLocale.supportedLocales,
      localizationsDelegates: AppLocale.localizationsDelegates,
      builder: (context, child) => ErrorHandlerBuilder(child: child),
    );
  }
}
