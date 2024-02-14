import '../../../../stack/base/presentation/safe_cubit.dart';
import '../../domain/use_cases/add_favorite.dart';
import '../../domain/use_cases/get_books.dart';
import '../../domain/use_cases/get_favorites.dart';
import '../../domain/use_cases/remove_favorite.dart';
import '../ui/models/book_ui_model.dart';
import 'books_state.dart';

class BooksCubit extends SafeCubit<BooksState> {
  BooksCubit(
    this._getBooks,
    this._getFavorites,
    this._addFavorite,
    this._removeFavorite,
  ) : super(BooksInitial());

  final GetBooks _getBooks;
  final GetFavorites _getFavorites;
  final AddFavorite _addFavorite;
  final RemoveFavorite _removeFavorite;

  final List<BookUiModel> booksCache = [];
  final List<BookUiModel> favoriteBooksCache = [];

  int defaultPageSize = 10;

  Future<void> fetchBooks(String queryText) async {
    emit(BooksLoading());
    final result = await _getBooks(
      params: GetBooksParams(
        queryText: queryText,
        pageSize: defaultPageSize,
      ),
    );
    if (result.isSuccessful) {
      final uiModels = result.value!.items
          .map(
            (e) => BookUiModel.fromEntity(e)
              ..isFavorite = _checkIfBookInFavorites(e.id),
          )
          .toList();
      booksCache.clear();
      booksCache.addAll(uiModels);
      emit(BooksUpdated(booksCache, favoriteBooksCache));
      return;
    }
    emit(BooksFetchFailed());
  }

  Future<void> fetchFavorites() async {
    final result = await _getFavorites();
    if (result.isSuccessful) {
      final uiModels = result.value!
          .map((e) => BookUiModel.fromEntity(e)..isFavorite = true)
          .toList();
      favoriteBooksCache.clear();
      favoriteBooksCache.addAll(uiModels);
      emit(BooksUpdated(booksCache, favoriteBooksCache));
      return;
    }
    emit(FavoritesFetchFailed());
  }

  void searchFavoriteBooks(String searchText) {
    if (searchText.isEmpty) {
      for (final item in favoriteBooksCache) {
        item.isVisible = true;
      }
      emit(BooksUpdated(booksCache, favoriteBooksCache));
      return;
    }
    for (final item in favoriteBooksCache) {
      if (item.bookInfo.title
          .toLowerCase()
          .contains(searchText.toLowerCase())) {
        item.isVisible = true;
      } else {
        item.isVisible = false;
      }
    }
    emit(BooksUpdated(booksCache, favoriteBooksCache));
  }

  Future<void> addFavorite(BookUiModel book) async {
    if (_checkIfBookInFavorites(book.id)) return;
    final result = await _addFavorite(params: book.toEntity());
    if (result.isSuccessful) {
      book.isFavorite = true;
      favoriteBooksCache.add(book);
      emit(BooksUpdated(booksCache, favoriteBooksCache));
      return;
    }
    emit(AddFavoriteFailed());
  }

  Future<void> removeFavorite(BookUiModel book) async {
    final result = await _removeFavorite(params: book.id);
    if (result.isSuccessful) {
      book.isFavorite = false;
      favoriteBooksCache.remove(book);
      emit(BooksUpdated(booksCache, favoriteBooksCache));
      return;
    }
    emit(RemoveFavoriteFailed());
  }

  void resetFavoritesCacheVisibilities() {
    for (final item in favoriteBooksCache) {
      item.isVisible = true;
    }
  }

  // Helpers
  bool _checkIfBookInFavorites(String id) {
    return favoriteBooksCache.any((e) => e.id == id);
  }
  // - Helpers
}
