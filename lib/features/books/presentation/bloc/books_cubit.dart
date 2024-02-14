import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/base/presentation/safe_cubit.dart';
import '../../../../stack/common/mixins/use_case_cancel_mixin.dart';
import '../../domain/use_cases/get_books.dart';
import '../ui/models/book_ui_model.dart';
import 'books_state.dart';

class BooksCubit extends SafeCubit<BooksState> with UseCaseCancelMixin {
  BooksCubit(this._getBooks) : super(BooksInitial());

  final GetBooks _getBooks;

  @override
  List<UseCase<dynamic, dynamic, dynamic>> get useCasesToCancel => [];

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
      final uiModels =
          result.value!.items.map((e) => BookUiModel.fromEntity(e)).toList();
      booksCache.clear();
      booksCache.addAll(uiModels);
      emit(BooksUpdated(booksCache, favoriteBooksCache));
      return;
    }
    emit(BooksFetchFailed());
  }

  void searchFavoriteBooks(String searchText) {
    if (searchText.isEmpty) return;
    for (final item in favoriteBooksCache) {
      if (item.bookInfo.title.contains(searchText)) {
        item.isVisible = true;
      }
      item.isVisible = false;
    }
    emit(BooksUpdated(booksCache, favoriteBooksCache));
  }

  void addFavorite(BookUiModel book) {
    book.isFavorite = true;
    favoriteBooksCache.add(book);
    emit(BooksUpdated(booksCache, favoriteBooksCache));
  }

  void removeFavorite(BookUiModel book) {
    book.isFavorite = false;
    favoriteBooksCache.remove(book);
    emit(BooksUpdated(booksCache, favoriteBooksCache));
  }
}
