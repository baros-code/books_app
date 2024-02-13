import '../../../../stack/common/models/failure.dart';
import '../../../../stack/common/models/result.dart';
import '../../domain/entities/books_response.dart';
import '../../domain/repositories/books_repository.dart';
import '../../domain/use_cases/get_books.dart';
import '../data_sources/remote/books_remote_service.dart';

class BooksRepositoryImpl implements BooksRepository {
  BooksRepositoryImpl(
    this._remoteService,
  );

  final BooksRemoteService _remoteService;

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
}
