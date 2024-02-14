import '../configs/router/route_manager.dart';
import '../features/books/presentation/bloc/books_cubit.dart';
import '../stack/base/data/local_storage.dart';
import '../stack/core/ioc/service_locator.dart';
import '../stack/core/theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../stack/core/logging/logger.dart';
import '../stack/core/network/api_manager.dart';

class MainApp extends StatefulWidget {
  const MainApp({
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
  State<MainApp> createState() => _MyAppState();
}

class _MyAppState extends State<MainApp> {
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
