import 'package:equatable/equatable.dart';

import 'book.dart';

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
