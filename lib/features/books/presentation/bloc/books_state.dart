import '../ui/models/book_ui_model.dart';

abstract class BooksState {}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksUpdated extends BooksState {
  BooksUpdated(this.books);

  final List<BookUiModel> books;
}

class BooksFetchFailed extends BooksState {}
