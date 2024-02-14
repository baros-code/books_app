import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/router/route_manager.dart';
import '../../../../features/books/presentation/bloc/books_cubit.dart';
import '../../../../features/books/presentation/bloc/books_state.dart';
import '../../../../stack/base/presentation/controller.dart';

class SplashPageController extends Controller<Object> {
  SplashPageController(
    super.logger,
    super.popupManager,
  );

  late BooksCubit _booksCubit;

  @override
  void onStart() {
    super.onStart();
    _booksCubit = context.read<BooksCubit>();
    _booksCubit.fetchFavorites();
  }

  void handleStates(BooksState state) {
    if (state is BooksUpdated || state is FavoritesFetchFailed) {
      context.goNamed(RouteConfig.homeRoute.name);
    }
  }
}
