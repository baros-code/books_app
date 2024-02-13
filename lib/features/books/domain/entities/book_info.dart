import 'package:equatable/equatable.dart';

import 'book_image_links.dart';

class BookInfo extends Equatable {
  const BookInfo({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.imageLinks,
  });

  final String title;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final String description;
  final int pageCount;
  final BookImageLinks imageLinks;

  BookInfo.initial()
      : title = '',
        authors = [],
        publisher = '',
        publishedDate = '',
        description = '',
        pageCount = -1,
        imageLinks = const BookImageLinks.initial();

  @override
  List<Object> get props => [
        title,
        authors,
        publisher,
        publishedDate,
        description,
        pageCount,
        imageLinks,
      ];
}
