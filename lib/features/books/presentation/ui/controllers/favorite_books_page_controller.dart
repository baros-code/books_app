import '../../bloc/books_cubit.dart';
import '../models/book_ui_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../stack/base/presentation/controller.dart';

class FavoriteBooksPageController extends Controller<Object> {
  FavoriteBooksPageController(
    super.logger,
    super.popupManager,
  );

  late BooksCubit _booksCubit;
  List<BookUiModel> get books => _booksCubit.favoriteBooksCache;

  @override
  void onStart() {
    // TODO: implement onStart
    super.onStart();
    _booksCubit = context.read<BooksCubit>();
  }

  void searchBooks(String searchText) {
    _booksCubit.searchFavoriteBooks(searchText);
  }

  void addFavorite(BookUiModel book) {
    _booksCubit.addFavorite(book);
  }

  void removeFavorite(BookUiModel book) {
    _booksCubit.removeFavorite(book);
  }
}
