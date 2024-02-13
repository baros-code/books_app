// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookInfoModel _$BookInfoModelFromJson(Map<String, dynamic> json) =>
    BookInfoModel(
      title: json['title'] as String?,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      publisher: json['publisher'] as String?,
      publishedDate: json['publishedDate'] as String?,
      description: json['description'] as String?,
      pageCount: json['pageCount'] as int?,
      imageLinks: json['imageLinks'] == null
          ? null
          : BookImageLinksModel.fromJson(
              json['imageLinks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookInfoModelToJson(BookInfoModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'pageCount': instance.pageCount,
      'imageLinks': instance.imageLinks,
    };
