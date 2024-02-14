import 'package:books_app/shared/constants/custom_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/ui/custom/widgets/custom_card.dart';
import '../../../../../../shared/presentation/ui/custom/widgets/custom_text.dart';
import '../../models/book_ui_model.dart';

class BookCard extends StatefulWidget {
  const BookCard(
    this.book, {
    super.key,
    required this.onDoubleTap,
    required this.onLongPress,
  });

  final BookUiModel book;
  final void Function(BookUiModel) onDoubleTap;
  final void Function(BookUiModel) onLongPress;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  late BookUiModel _book;

  @override
  void initState() {
    super.initState();
    _book = widget.book.copyWith();
  }

  @override
  Widget build(BuildContext context) {
    final title = _book.bookInfo.title;
    final author = _book.bookInfo.author;
    final publisher = _book.bookInfo.publisher;
    final publishedDate = _book.bookInfo.publishedDate;
    final pageCount = _book.bookInfo.pageCount;
    return InkWell(
      onDoubleTap: () {
        if (_book.isFavorite) return;
        setState(() {
          _book.isFavorite = true;
          widget.onDoubleTap(_book);
        });
      },
      onLongPress: () {
        if (!_book.isFavorite) return;
        setState(() {
          _book.isFavorite = false;
          widget.onLongPress(_book);
        });
      },
      child: CustomCard(
        height: 125,
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.transparent,
        enableShadows: false,
        showBorder: true,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderColor: const Color(0xFF4893EB),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: _book.bookInfo.imageLinks.thumbnail,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset(CustomImages.bookPlaceHolder),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardContent(
                    title,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
                  _CardContent(
                    'Author: $author',
                    isVisible: _book.bookInfo.author.isNotEmpty,
                  ),
                  _CardContent(
                    'Publisher: $publisher',
                    isVisible: _book.bookInfo.publisher.isNotEmpty,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _CardContent(
                        'Published Date: $publishedDate',
                        isVisible: publishedDate.isNotEmpty,
                      ),
                      if (publishedDate.isNotEmpty) const SizedBox(width: 8),
                      _CardContent(
                        'Page Count: $pageCount',
                        isVisible: pageCount != -1,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent(
    this.content, {
    this.isVisible = true,
    this.textStyle,
  });

  final String content;
  final bool isVisible;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? CustomText(
            content,
            isSingleLine: true,
            style: textStyle ?? const TextStyle(color: Colors.white),
          )
        : const SizedBox.shrink();
  }
}
