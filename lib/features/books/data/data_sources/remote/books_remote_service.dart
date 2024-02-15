import '../../../../../stack/common/models/failure.dart';
import '../../../../../stack/common/models/result.dart';
import '../../../../../stack/core/network/api_manager.dart';
import '../../../domain/use_cases/get_books.dart';
import '../../models/books_response.dart';
import 'books_api.dart';

abstract class BooksRemoteService {
  Future<Result<BooksResponseModel, Failure>> getBooks(GetBooksParams params);
}

class BooksRemoteServiceImpl implements BooksRemoteService {
  BooksRemoteServiceImpl(this._apiManager);

  final ApiManager _apiManager;

  @override
  Future<Result<BooksResponseModel, Failure>> getBooks(
    GetBooksParams params,
  ) async {
    return _apiManager.call(
      BooksApi.getBooks(
        queryText: params.queryText,
        pageSize: params.pageSize,
        pageIndex: params.startIndex,
      ),
    );
  }
}
