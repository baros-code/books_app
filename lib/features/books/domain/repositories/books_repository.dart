import '../entities/books_response.dart';
import '../use_cases/get_books.dart';

import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';

abstract class BooksRepository {
  Future<Result<BooksResponse, Failure>> getBooks(GetBooksParams params);
}
