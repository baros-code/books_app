import '../../../../../stack/common/models/api/api_call.dart';
import '../../../../../stack/common/models/api/api_method.dart';
import '../../models/books_response.dart';

abstract class BooksApi {
  static const String apiKey = 'AIzaSyBZM1yCKKF7USHU9bOgb4fMyis4FaLoV8s';

  static ApiCall<BooksResponseModel> getBooks({
    String? queryText,
    int? pageSize,
    int? pageIndex,
  }) {
    final queryParams = {
      'q': queryText,
      'maxResults': pageSize,
      'startIndex': pageIndex,
      // Add this parameter for getting only books by excluding magazines
      'printType': 'books',
      'key': apiKey,
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
