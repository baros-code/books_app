import 'package:flutter/material.dart';

import 'constants.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTheme = const TextTheme();

  static TextTheme darkTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
    labelSmall: const TextStyle().copyWith(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ThemeConstants.darkThemeTextPrimaryColor,
    ),
  );
}
