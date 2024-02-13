import '../../../../../configs/router/route_manager.dart';
import '../../bloc/books_cubit.dart';
import '../../../../../stack/base/presentation/controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BooksPageController extends Controller<bool> {
  BooksPageController(super.logger, super.popupManager);

  late final bool isFavoritesPage;
  late BooksCubit _booksCubit;

  @override
  void onStart() {
    super.onStart();
    isFavoritesPage = params!;
    _booksCubit = context.read<BooksCubit>();
    _booksCubit.fetchBooks('müzik');
  }

  void goToFavoritesPage() {
    context.goNamed(RouteConfig.favoritesRoute.name);
  }
}
