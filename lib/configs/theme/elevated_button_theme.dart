import 'package:flutter/material.dart';

import 'constants.dart';
import 'text_theme.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static ElevatedButtonThemeData lightTheme = const ElevatedButtonThemeData();

  static ElevatedButtonThemeData darkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: ThemeConstants.darkThemeTextPrimaryColor,
      backgroundColor: ThemeConstants.darkThemePrimaryColor,
      disabledForegroundColor: ThemeConstants.darkThemeTextPrimaryColor,
      disabledBackgroundColor:
          ThemeConstants.darkThemeDisabledButtonBackgroundColor,
      side: const BorderSide(
        color: ThemeConstants.darkThemePrimaryColor,
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      textStyle: TTextTheme.darkTheme.titleLarge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
