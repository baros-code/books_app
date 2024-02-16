import 'package:flutter/material.dart';

import 'constants.dart';
import 'text_theme.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static AppBarTheme get lightTheme => const AppBarTheme();

  static AppBarTheme get darkTheme => AppBarTheme(
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: ThemeConstants.darkThemeAppBarBackgroundColor,
        surfaceTintColor: ThemeConstants.darkThemeAppBarBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
        actionsIconTheme: const IconThemeData(color: Colors.white, size: 24),
        titleTextStyle: TTextTheme.darkTheme.headlineSmall,
      );
}
