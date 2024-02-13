import 'dart:async';

import 'package:flutter/material.dart';

import 'configs/api_config.dart';
import 'configs/dependency_config.dart';
import 'configs/router/route_manager.dart';
import 'stack/base/data/local_storage.dart';
import 'stack/core/ioc/service_locator.dart';
import 'stack/core/logging/logger.dart';
import 'stack/core/network/api_manager.dart';
import 'stack/core/theme/dynamic_theme.dart';
import 'stack/core/theme/theme_manager.dart';

void main() {
  // Run app handling Dart errors.
  runZonedGuarded(
    () async {
      // Initialize all the app components.
      await _initializeComponents();
      // Handle Flutter errors.
      FlutterError.onError = _onFlutterError;
      // Run main app.
      runApp(
        MyApp(
          logger: locator<Logger>(),
          apiManager: locator<ApiManager>(),
          // Get the currently saved theme mode to prevent flashing.
          themeMode: await locator<ThemeManager>().getThemeMode(),
          lightTheme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
        ),
      );
    },
    // Handle Dart errors.
    _onDartError,
  );
}

Future<void> _initializeComponents() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.initialize(external: DependencyConfig.register);
  locator<ApiManager>().setup(ApiConfig.setupParams);
  locator<Logger>();
}

void _onFlutterError(FlutterErrorDetails error) {
  FlutterError.presentError(error);
  locator<Logger>().critical(
    error.toString(minLevel: DiagnosticLevel.error),
  );
}

void _onDartError(Object error, StackTrace stack) {
  locator<Logger>().critical(
    '${error.toString()}\n${stack.toString()}',
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.logger,
    required this.apiManager,
    required this.lightTheme,
    required this.darkTheme,
    this.themeMode,
  });

  final Logger logger;
  final ApiManager apiManager;
  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final ThemeMode? themeMode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      lightTheme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialMode: widget.themeMode ?? ThemeMode.light,
      builder: (theme, darkTheme) {
        return MaterialApp.router(
          routerConfig: RouteManager.router,
          title: 'Books App',
          theme: theme,
          darkTheme: darkTheme,
        );
      },
    );
  }

  @override
  void dispose() async {
    await LocalStorage.dispose();
    super.dispose();
  }

  // List<BlocProvider> _buildCubitProviders() {
  //   return [
  //     BlocProvider<AuthCubit>(
  //       create: (context) => locator<AuthCubit>(),
  //     ),
  //     BlocProvider<FleetsCubit>(
  //       create: (context) => locator<FleetsCubit>(),
  //     ),
  //   ];
  // }
  // - Helpers
}
