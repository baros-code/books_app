import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/common/models/result.dart';
import '../repositories/books_repository.dart';

class RemoveFavorite extends UseCase<String, Result, void> {
  RemoveFavorite(this._repository, super.logger);

  final BooksRepository _repository;

  @override
  Future<Result> execute({String? params}) {
    return _repository.removeFavorite(params!);
  }
}
