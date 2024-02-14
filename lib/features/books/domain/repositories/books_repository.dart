import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../entities/book.dart';
import '../entities/books_response.dart';
import '../use_cases/get_books.dart';

abstract class BooksRepository {
  Future<Result<BooksResponse, Failure>> getBooks(GetBooksParams params);

  Future<Result<List<Book>, Failure>> getFavorites();

  Future<Result> addFavorite(Book book);

  Future<Result> removeFavorite(String bookId);
}
