import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_pos/core/constants/export.dart';
import 'package:flutter_pos/core/presentation/export.dart';
import 'package:flutter_pos/managers/export.dart';

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeState>(
  ThemeNotifier.new,
);

class ThemeNotifier extends Notifier<ThemeState> {
  SharedPreferences get _sharedPreferences => getIt();

  @override
  ThemeState build() {
    final sharedPreferences = _sharedPreferences;
    final value = sharedPreferences.getString(Constants.selectedBrightnessKey);
    final isLight = value == 'light';
    final brightness = isLight ? Brightness.light : Brightness.dark;

    return ThemeState(
      isLight: isLight,
      themeData: AppTheme().init(brightness: brightness),
    );
  }

  void changeBrightness(bool isLight) async {
    final sharedPreferences = _sharedPreferences;
    await sharedPreferences.setString(
      Constants.selectedBrightnessKey,
      isLight ? 'light' : 'dark',
    );
    final brightness = isLight ? Brightness.light : Brightness.dark;
    state = ThemeState(
      isLight: isLight,
      themeData: AppTheme().init(brightness: brightness),
    );
  }
}
