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
      emit(BooksUpdated(booksCache));
      return;
    }
    emit(BooksFetchFailed());
  }

  void searchFavoriteBooks(String searchText) {
    if (searchText.isEmpty) return;
    final filteredBooks = favoriteBooksCache
        .where((e) => e.bookInfo.title.contains(searchText))
        .toList();
    emit(BooksUpdated(filteredBooks));
  }

  void addFavorite(BookUiModel book) {
    favoriteBooksCache.add(book);
  }

  void removeFavorite(BookUiModel book) {
    favoriteBooksCache.remove(book);
  }
}
