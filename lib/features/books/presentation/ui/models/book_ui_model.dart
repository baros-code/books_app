import '../../../domain/entities/book.dart';
import '../../../domain/entities/book_info.dart';

// ignore: must_be_immutable
class BookUiModel extends Book {
  BookUiModel({
    required super.id,
    required super.bookInfo,
    this.isVisible = true,
    this.isFavorite = false,
  });

  bool isVisible;
  bool isFavorite;

  Book toEntity() {
    return Book(
      id: id,
      bookInfo: bookInfo,
    );
  }

  static BookUiModel fromEntity(Book entity) {
    return BookUiModel(
      id: entity.id,
      bookInfo: entity.bookInfo,
      isVisible: true,
      isFavorite: false,
    );
  }

  BookUiModel copyWith({
    String? id,
    BookInfo? bookInfo,
    bool? isVisible,
    bool? isFavorite,
  }) {
    return BookUiModel(
      id: id ?? this.id,
      bookInfo: bookInfo ?? this.bookInfo,
      isVisible: isVisible ?? this.isVisible,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
