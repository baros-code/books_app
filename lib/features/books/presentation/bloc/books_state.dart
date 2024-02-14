import '../ui/models/book_ui_model.dart';

abstract class BooksState {}

class BooksInitial extends BooksState {}

class BooksLoading extends BooksState {}

class BooksUpdated extends BooksState {
  BooksUpdated(this.books, this.favoriteBooks);

  final List<BookUiModel> books;
  final List<BookUiModel> favoriteBooks;
}

class BooksFetchFailed extends BooksState {}
