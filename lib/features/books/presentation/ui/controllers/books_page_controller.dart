import 'package:books_app/features/books/presentation/ui/models/book_ui_model.dart';

import '../../../../../configs/router/route_manager.dart';
import '../../bloc/books_cubit.dart';
import '../../../../../stack/base/presentation/controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BooksPageController extends Controller<Object> {
  BooksPageController(super.logger, super.popupManager);

  late BooksCubit _booksCubit;

  List<BookUiModel> get books => _booksCubit.booksCache;

  @override
  void onStart() {
    super.onStart();
    _booksCubit = context.read<BooksCubit>();
  }

  void goToFavoritesPage() {
    context.goNamed(RouteConfig.favoritesRoute.name);
  }

  void searchBooks(String searchText) {
    if (searchText.isEmpty) return;
    _booksCubit.fetchBooks(searchText);
  }

  void addFavorite(BookUiModel book) {
    _booksCubit.addFavorite(book);
  }

  void removeFavorite(BookUiModel book) {
    _booksCubit.removeFavorite(book);
  }
}
