import '../../domain/entities/book.dart';

abstract class BooksState {}

class BooksInitial extends BooksState {}

class BooksFetchSucceeded extends BooksState {
  BooksFetchSucceeded(this.books);

  final List<Book> books;
}

class BooksFetchFailed extends BooksState {}
