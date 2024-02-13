import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class DynamicTheme extends AdaptiveTheme {
  DynamicTheme({
    super.key,
    required ThemeData lightTheme,
    ThemeData? darkTheme,
    required ThemeMode initialMode,
    required super.builder,
  }) : super(
          light: lightTheme,
          dark: darkTheme,
          initial: AdaptiveThemeMode.values.byName(
            initialMode.toString().split('.').last,
          ),
        );
}
