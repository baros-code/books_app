import 'package:books_app/features/books/domain/entities/book.dart';
import 'package:equatable/equatable.dart';

class BooksResponse extends Equatable {
  const BooksResponse({
    required this.totalItems,
    required this.items,
  });

  final int totalItems;
  final List<Book> items;

  @override
  List<Object> get props => [totalItems, items];
}