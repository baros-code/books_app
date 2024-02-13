import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/book_image_links.dart';

part 'book_image_links_model.g.dart';

@JsonSerializable()
class BookImageLinksModel {
  BookImageLinksModel({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  final String? smallThumbnail;
  final String? thumbnail;

  factory BookImageLinksModel.fromJson(Map<String, dynamic> json) =>
      _$BookImageLinksModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookImageLinksModelToJson(this);

  factory BookImageLinksModel.fromEntity(BookImageLinks entity) {
    return BookImageLinksModel(
      smallThumbnail: entity.smallThumbnail,
      thumbnail: entity.thumbnail,
    );
  }

  BookImageLinks toEntity() {
    return BookImageLinks(
      smallThumbnail: smallThumbnail ?? '',
      thumbnail: thumbnail ?? '',
    );
  }
}
