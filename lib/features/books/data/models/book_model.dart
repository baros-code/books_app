import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/book.dart';
import '../../domain/entities/book_info.dart';
import 'book_info_model.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel {
  BookModel({
    required this.id,
    required this.bookInfo,
  });

  final String? id;
  @JsonKey(name: 'volumeInfo')
  final BookInfoModel? bookInfo;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookModelToJson(this);

  @override
  String toString() => '{${bookInfo?.title} with id: $id)}';

  factory BookModel.fromEntity(Book entity) {
    return BookModel(
      id: entity.id,
      bookInfo: BookInfoModel.fromEntity(entity.bookInfo),
    );
  }

  Book toEntity() {
    return Book(
      id: id ?? '',
      bookInfo: bookInfo?.toEntity() ?? BookInfo.initial(),
    );
  }
}
