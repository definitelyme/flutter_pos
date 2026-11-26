import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_pos/core/presentation/export.dart';
import 'package:flutter_pos/managers/export.dart';

class ErrorScreen extends StatelessWidget {
  final ErrorScreenParam param;

  const ErrorScreen({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppErrorWidget(
              error: param.error ?? param.flutterError,
              message: param.message,
            ),
            const SizedBox(height: AppSizes.padding),
            AppButton(
              buttonColor: Theme.of(context).colorScheme.surface,
              borderColor: Theme.of(context).colorScheme.surfaceContainerLowest,
              textColor: Theme.of(context).colorScheme.primary,
              alignment: null,
              text: 'Back to home',
              onTap: () {
                // Go back to default initial route
                context.go('/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
