import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../entities/books_response.dart';
import '../repositories/books_repository.dart';

class GetBooks
    extends UseCase<GetBooksParams, Result<BooksResponse, Failure>, void> {
  GetBooks(this._repository, super.logger);

  final BooksRepository _repository;

  @override
  Future<Result<BooksResponse, Failure>> execute({GetBooksParams? params}) {
    return _repository.getBooks(params!);
  }
}

class GetBooksParams {
  GetBooksParams({
    required this.queryText,
    required this.pageSize,
    required this.startIndex,
  });

  final String queryText;
  final int pageSize;
  final int startIndex;
}
