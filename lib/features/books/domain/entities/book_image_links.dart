import 'package:equatable/equatable.dart';

class BookImageLinks extends Equatable {
  const BookImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  final String smallThumbnail;
  final String thumbnail;

  @override
  List<Object> get props => [smallThumbnail, thumbnail];

  const BookImageLinks.initial()
      : smallThumbnail = '',
        thumbnail = '';
}
