import 'package:books_app/shared/constants/custom_images.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../shared/presentation/ui/custom/widgets/custom_card.dart';
import '../../models/book_ui_model.dart';

class BookCard extends StatefulWidget {
  const BookCard(
    this.book, {
    super.key,
    required this.onDoubleTap,
    required this.onLongPress,
  });

  final BookUiModel book;
  final void Function() onDoubleTap;
  final void Function() onLongPress;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  late bool _isFavorite;
  @override
  void initState() {
    super.initState();
    _isFavorite = widget.book.isFavorite;
  }

  @override
  void didUpdateWidget(covariant BookCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isFavorite = widget.book.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.book.bookInfo.title;
    final author = widget.book.bookInfo.author;
    final publisher = widget.book.bookInfo.publisher;
    final publishedDate = widget.book.bookInfo.publishedDate;
    final pageCount = widget.book.bookInfo.pageCount;
    final imageLinks = widget.book.bookInfo.imageLinks;
    return InkWell(
      onDoubleTap: () {
        if (_isFavorite) return;
        setState(() {
          widget.onDoubleTap();
        });
      },
      onLongPress: () {
        if (!_isFavorite) return;
        setState(() {
          widget.onLongPress();
        });
      },
      child: CustomCard(
        height: 125,
        padding: const EdgeInsets.all(8),
        backgroundColor: _isFavorite ? Colors.blue : Colors.transparent,
        enableShadows: false,
        showBorder: true,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderColor: const Color(0xFF4893EB),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageLinks.smallThumbnail,
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
                    isVisible: author.isNotEmpty,
                  ),
                  _CardContent(
                    'Publisher: $publisher',
                    isVisible: publisher.isNotEmpty,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _CardContent(
                        'Published Date: $publishedDate',
                        isVisible: publishedDate.isNotEmpty,
                      ),
                      if (publishedDate.isNotEmpty) const SizedBox(width: 8),
                      Expanded(
                        child: _CardContent(
                          'Pages: $pageCount',
                          isVisible: pageCount != -1,
                        ),
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
        ? Text(
            content,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyle ?? const TextStyle(color: Colors.white),
          )
        : const SizedBox.shrink();
  }
}
