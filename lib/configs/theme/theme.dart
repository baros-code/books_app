import 'package:flutter/material.dart';

import 'app_bar_theme.dart';
import 'constants.dart';
import 'elevated_button_theme.dart';
import 'text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData();
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: ThemeConstants.darkThemePrimaryColor,
      background: ThemeConstants.darkThemeBackgroundColor,
    ),
    primaryColor: ThemeConstants.darkThemeBackgroundColor,
    scaffoldBackgroundColor: ThemeConstants.darkThemeBackgroundColor,
    appBarTheme: TAppBarTheme.darkTheme,
    textTheme: TTextTheme.darkTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkTheme,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: ThemeConstants.darkThemePrimaryColor,
      contentTextStyle: TextStyle(
        color: ThemeConstants.darkThemeTextPrimaryColor,
      ),
    ),
  );
}
