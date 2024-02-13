import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/book_image_links.dart';
import '../../domain/entities/book_info.dart';
import 'book_image_links_model.dart';

part 'book_info_model.g.dart';

@JsonSerializable()
class BookInfoModel {
  BookInfoModel({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.imageLinks,
  });

  final String? title;
  final List<String>? authors;
  final String? publisher;
  final String? publishedDate;
  final String? description;
  final int? pageCount;
  final BookImageLinksModel? imageLinks;

  factory BookInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BookInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookInfoModelToJson(this);

  factory BookInfoModel.fromEntity(BookInfo entity) {
    return BookInfoModel(
      title: entity.title,
      authors: entity.authors,
      publisher: entity.publisher,
      publishedDate: entity.publishedDate,
      description: entity.description,
      pageCount: entity.pageCount,
      imageLinks: BookImageLinksModel.fromEntity(entity.imageLinks),
    );
  }

  BookInfo toEntity() {
    return BookInfo(
      title: title ?? 'Bilinmiyor',
      authors: authors ?? [],
      publisher: publisher ?? '',
      publishedDate: publishedDate ?? '',
      description: description ?? '',
      pageCount: pageCount ?? -1,
      imageLinks: imageLinks?.toEntity() ?? const BookImageLinks.initial(),
    );
  }
}
