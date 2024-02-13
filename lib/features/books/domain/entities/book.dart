import 'package:equatable/equatable.dart';

import 'book_info.dart';

class Book extends Equatable {
  const Book({
    required this.id,
    required this.bookInfo
  });

  final String id;
  final BookInfo bookInfo;

  @override
  List<Object> get props => [id];
}
