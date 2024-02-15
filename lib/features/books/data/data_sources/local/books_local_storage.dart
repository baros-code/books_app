import '../../../../../stack/base/data/local_storage.dart';
import '../../../../../stack/common/models/failure.dart';
import '../../../../../stack/common/models/result.dart';
import '../../models/book_model.dart';

abstract class BooksLocalStorage {
  Future<Result<List<BookModel>, Failure>> getFavorites();

  Future<Result> addFavorite(BookModel book);

  Future<Result> removeFavorite(String bookId);
}

class BooksLocalStorageImpl extends LocalStorage<BookModel>
    implements BooksLocalStorage {
  BooksLocalStorageImpl(super.logger);

  @override
  Future<Result<List<BookModel>, Failure>> getFavorites() async {
    final result = await getAll();
    if (result.isSuccessful) {
      return Result.success(value: result.value!.toList());
    } else {
      return Result.failure(result.error!);
    }
  }

  @override
  Future<Result> addFavorite(BookModel book) async {
    final result = await putSingle(book.id.toString(), book);
    if (result.isSuccessful) {
      return Result.success();
    } else {
      return Result.failure(result.error!);
    }
  }

  @override
  Future<Result> removeFavorite(String bookId) async {
    final result = await removeSingle(bookId.toString());
    if (result.isSuccessful) {
      return Result.success();
    } else {
      return Result.failure(result.error!);
    }
  }
}
