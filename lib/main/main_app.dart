import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../configs/route_config.dart';
import '../configs/theme/theme.dart';
import '../features/books/presentation/bloc/books_cubit.dart';
import '../stack/base/data/local_storage.dart';
import '../stack/core/ioc/service_locator.dart';
import '../stack/core/logging/logger.dart';
import '../stack/core/network/api_manager.dart';

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
    required this.logger,
    required this.apiManager,
  });

  final Logger logger;
  final ApiManager apiManager;

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
    return MultiBlocProvider(
      providers: _buildCubitProviders(),
      child: MaterialApp.router(
        themeMode: ThemeMode.dark,
        routerConfig: RouteConfig.router,
        title: 'Books App',
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
      ),
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
