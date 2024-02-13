import 'package:books_app/features/books/data/models/book_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/books_response.dart';

part 'books_response.g.dart';

@JsonSerializable()
class BooksResponseModel {
  BooksResponseModel({
    required this.totalItems,
    required this.items,
  });

  final int? totalItems;
  final List<BookModel>? items;

  factory BooksResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BooksResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BooksResponseModelToJson(this);

  factory BooksResponseModel.fromEntity(BooksResponse entity) {
    return BooksResponseModel(
      totalItems: entity.totalItems,
      items: entity.items.map((e) => BookModel.fromEntity(e)).toList(),
    );
  }

  BooksResponse toEntity() {
    return BooksResponse(
      totalItems: totalItems ?? -1,
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
