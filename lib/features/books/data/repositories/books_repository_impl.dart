import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../../domain/entities/book.dart';
import '../../domain/entities/books_response.dart';
import '../../domain/repositories/books_repository.dart';
import '../../domain/use_cases/get_books.dart';
import '../data_sources/local/books_local_storage.dart';
import '../data_sources/remote/books_remote_service.dart';
import '../models/book_model.dart';

class BooksRepositoryImpl implements BooksRepository {
  BooksRepositoryImpl(
    this._remoteService,
    this._localStorage,
  );

  final BooksRemoteService _remoteService;
  final BooksLocalStorage _localStorage;

  @override
  Future<Result<BooksResponse, Failure>> getBooks(GetBooksParams params) async {
    try {
      final result = await _remoteService.getBooks(params);
      if (result.isSuccessful) {
        return Result.success(value: result.value!.toEntity());
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result<List<Book>, Failure>> getFavorites() async {
    try {
      final result = await _localStorage.getFavorites();
      if (result.isSuccessful) {
        return Result.success(
          value: result.value!.map((e) => e.toEntity()).toList(),
        );
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result> addFavorite(Book book) async {
    try {
      final result =
          await _localStorage.addFavorite(BookModel.fromEntity(book));
      if (result.isSuccessful) {
        return Result.success();
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }

  @override
  Future<Result> removeFavorite(String bookId) async {
    try {
      final result = await _localStorage.removeFavorite(bookId);
      if (result.isSuccessful) {
        return Result.success();
      }
      return Result.failure(result.error);
    } catch (e) {
      return Result.failure(Failure(message: e.toString()));
    }
  }
}
