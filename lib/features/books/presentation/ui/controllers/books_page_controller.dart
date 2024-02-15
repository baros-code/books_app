import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../configs/router/route_manager.dart';
import '../../../../../stack/base/presentation/controller.dart';
import '../../bloc/books_cubit.dart';
import '../../bloc/books_state.dart';
import '../models/book_ui_model.dart';

class BooksPageController extends Controller<Object> {
  BooksPageController(super.logger, super.popupManager);

  final int _searchCharacterLimit = 500;

  String currentSearchText = '';

  late BooksCubit _booksCubit;

  List<BookUiModel> get books => _booksCubit.booksCache;

  int get pageSize => _booksCubit.defaultPageSize;

  bool get isInitialLoading => _booksCubit.isInitialLoading;

  int get maxItemCount => _booksCubit.maxItemCount;

  @override
  void onStart() {
    super.onStart();
    _booksCubit = context.read<BooksCubit>();
    _booksCubit.stream.listen(_handleStates);
  }

  void _handleStates(BooksState state) {
    if (state is AddFavoriteFailed) {
      popupManager.showSnackBar(
        context,
        backgroundColor: const Color(0xFF4893EB),
        const Text('Favorilere eklenirken bir hata oluştu.'),
      );
    } else if (state is RemoveFavoriteFailed) {
      popupManager.showSnackBar(
        context,
        backgroundColor: const Color(0xFF4893EB),
        const Text('Favorilerden kaldırılırken bir hata oluştu.'),
      );
    }
  }

  Future<bool> fetchBooks(int pageIndex) {
    return _booksCubit.fetchBooks(currentSearchText, pageIndex: pageIndex);
  }

  void goToFavoritesPage() {
    context.goNamed(RouteConfig.favoritesRoute.name);
  }

  void searchBooks(String searchText) {
    if (searchText.isEmpty) return;
    if (searchText.length >= _searchCharacterLimit) {
      popupManager.showSnackBar(
        context,
        backgroundColor: const Color(0xFF4893EB),
        Text('Arama metni $_searchCharacterLimit karakterden fazla olamaz.'),
      );
      return;
    }
    currentSearchText = searchText;
    _booksCubit.fetchBooks(searchText);
  }

  void addFavorite(BookUiModel book) {
    _booksCubit.addFavorite(book);
  }

  void removeFavorite(BookUiModel book) {
    _booksCubit.removeFavorite(book);
  }
}
