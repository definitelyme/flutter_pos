import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/bootstrap/app_initializer.dart';
import 'package:flutter_pos/app_view.dart';

Future<void> main() async {
  await bootstrapApp();

  runApp(const ProviderScope(child: AppView()));
}
