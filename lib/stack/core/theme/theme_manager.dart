import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

/// A tool to handle theming over the course of the app lifecycle.
abstract class ThemeManager {
  /// Gets the currently saved theme mode.
  Future<ThemeMode?> getThemeMode();

  /// Changes the current theme mode with the given [newThemeMode].
  void changeThemeMode(BuildContext context, ThemeMode newThemeMode);

  /// Toggles the current theme mode between light and dark.
  void toggleThemeMode(BuildContext context);
}

/// ThemeManager Implementation
class ThemeManagerImpl implements ThemeManager {
  @override
  Future<ThemeMode?> getThemeMode() async {
    try {
      final mode = await AdaptiveTheme.getThemeMode();
      return mode != null
          ? ThemeMode.values.byName(mode.name)
          : ThemeMode.light;
    } catch (_) {
      return null;
    }
  }

  @override
  void changeThemeMode(BuildContext context, ThemeMode newThemeMode) {
    AdaptiveTheme.of(context).setThemeMode(
      AdaptiveThemeMode.values.byName(newThemeMode.name),
    );
  }

  @override
  void toggleThemeMode(BuildContext context) {
    final currentThemeMode = AdaptiveTheme.of(context).mode;
    if (currentThemeMode == AdaptiveThemeMode.system) {
      // Get the current system brightness to decide the theme to switch.
      final brightness = PlatformDispatcher.instance.platformBrightness;
      if (brightness == Brightness.light) {
        AdaptiveTheme.of(context).setDark();
      } else {
        AdaptiveTheme.of(context).setLight();
      }
    } else if (currentThemeMode == AdaptiveThemeMode.light) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }
}
