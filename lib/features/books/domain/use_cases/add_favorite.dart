import 'package:books_app/features/books/domain/entities/book.dart';

import '../../../../stack/base/domain/use_case.dart';
import '../../../../stack/common/models/result.dart';
import '../repositories/books_repository.dart';

class AddFavorite extends UseCase<Book, Result, void> {
  AddFavorite(this._repository, super.logger);

  final BooksRepository _repository;

  @override
  Future<Result> execute({Book? params}) {
    return _repository.addFavorite(params!);
  }
}
