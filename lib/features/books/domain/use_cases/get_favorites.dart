import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../entities/book.dart';
import '../repositories/books_repository.dart';

class GetFavorites extends UseCase<void, Result<List<Book>, Failure>, void> {
  GetFavorites(this._repository, super.logger);

  final BooksRepository _repository;

  @override
  Future<Result<List<Book>, Failure>> execute({void params}) {
    return _repository.getFavorites();
  }
}
