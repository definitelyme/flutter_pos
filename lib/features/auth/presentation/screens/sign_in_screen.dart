import 'dart:async';

import 'package:app_image/app_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_pos/core/assets/export.dart';
import 'package:flutter_pos/core/presentation/export.dart';
import 'package:flutter_pos/features/auth/presentation/export.dart';
import 'package:flutter_pos/managers/export.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [
            _WelcomeMessage(),
            _SignInButton(),
            if (kDebugMode) ...[
              SizedBox(height: AppSizes.padding / 2),
              _TestAccountSignInButton(),
            ],
          ],
        ),
      ),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 270),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppImage(
              image: Assets.welcome,
              imgProvider: ImgProvider.assetImage,
            ),
            const SizedBox(height: AppSizes.padding),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Welcome to Flutter POS app',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _SignInButton extends ConsumerWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton(
      text: 'Sign In With Google',
      onTap: () async {
        var res = await AppDialog.showProgress(() async {
          return ref.read(authNotifierProvider.notifier).signIn();
        });

        if (res.isSuccess) {
          ref.read(appRoutesProvider).router.refresh();
        } else {
          unawaited(AppDialog.showError(error: res.error?.toString()));
        }
      },
    );
  }
}

class _TestAccountSignInButton extends ConsumerWidget {
  const _TestAccountSignInButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton(
      text: 'Sign in with test account',
      buttonColor: Theme.of(context).colorScheme.surface,
      borderColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.primary,
      onTap: () async {
        var res = await AppDialog.showProgress(() async {
          return ref.read(authNotifierProvider.notifier).signInWithTestAccount();
        });

        if (res.isSuccess) {
          ref.read(appRoutesProvider).router.refresh();
        } else {
          unawaited(AppDialog.showError(error: res.error?.toString()));
        }
      },
    );
  }
}
