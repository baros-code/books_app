import '../../domain/use_cases/get_books.dart';
import 'books_state.dart';
import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/base/presentation/safe_cubit.dart';
import '../../../../stack/common/mixins/use_case_cancel_mixin.dart';

class BooksCubit extends SafeCubit<BooksState> with UseCaseCancelMixin {
  BooksCubit(this._getBooks) : super(BooksInitial());

  final GetBooks _getBooks;

  @override
  List<UseCase<dynamic, dynamic, dynamic>> get useCasesToCancel => [];

  int defaultPageSize = 10;

  Future<void> fetchBooks(String queryText) async {
    final result = await _getBooks(
      params: GetBooksParams(
        queryText: queryText,
        pageSize: defaultPageSize,
      ),
    );
    if (result.isSuccessful) {
      emit(BooksFetchSucceeded(result.value!.items));
    } else {
      emit(BooksFetchFailed());
    }
  }
}
