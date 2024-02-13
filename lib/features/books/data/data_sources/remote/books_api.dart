import '../../../../../stack/common/models/api/api_call.dart';
import '../../../../../stack/common/models/api/api_method.dart';
import '../../models/books_response.dart';

abstract class BooksApi {
  static ApiCall<BooksResponseModel> getBooks({
    String? queryText,
    int? pageSize,
  }) {
    final queryParams = {
      'q': queryText,
      'maxResults': pageSize,
    };
    queryParams.removeWhere((key, value) => value == null);

    return ApiCall(
      method: ApiMethod.get,
      path: '/books/v1/volumes',
      queryParams: queryParams,
      responseMapper: (response) => BooksResponseModel.fromJson(response),
    );
  }
}
