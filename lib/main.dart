import 'dart:async';

import 'package:books_app/features/books/presentation/bloc/books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  runZonedGuarded(
    () async {
      await _initializeComponents();
      FlutterError.onError = _onFlutterError;
      runApp(
        MyApp(
          logger: locator<Logger>(),
          apiManager: locator<ApiManager>(),
          themeMode: await locator<ThemeManager>().getThemeMode(),
          lightTheme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
        ),
      );
    },
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
        return MultiBlocProvider(
          providers: _buildCubitProviders(),
          child: MaterialApp.router(
            routerConfig: RouteManager.router,
            title: 'Books App',
            theme: theme,
            darkTheme: darkTheme,
          ),
        );
      },
    );
  }

  @override
  void dispose() async {
    await LocalStorage.dispose();
    super.dispose();
  }

  // Helpers
  List<BlocProvider> _buildCubitProviders() {
    return [
      BlocProvider<BooksCubit>(
        create: (context) => locator<BooksCubit>(),
      ),
    ];
  }
  // - Helpers
}
