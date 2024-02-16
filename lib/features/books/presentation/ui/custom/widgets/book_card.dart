import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../configs/asset_config.dart';
import '../../../../../../shared/presentation/extensions/build_context_ext.dart';
import '../../../../../../shared/presentation/ui/custom/widgets/custom_card.dart';
import '../../models/book_ui_model.dart';

class BookCard extends StatefulWidget {
  const BookCard(
    this.book, {
    super.key,
    this.onDoubleTap,
    required this.onLongPress,
  });

  final BookUiModel book;
  final void Function()? onDoubleTap;
  final void Function() onLongPress;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    final isFavorite = widget.book.isFavorite;
    final title = widget.book.bookInfo.title;
    final author = widget.book.bookInfo.author;
    final publisher = widget.book.bookInfo.publisher;
    final publishedDate = widget.book.bookInfo.publishedDate;
    final pageCount = widget.book.bookInfo.pageCount;
    final imageLinks = widget.book.bookInfo.imageLinks;
    return InkWell(
      onDoubleTap: () {
        if (isFavorite) return;
        setState(() {
          widget.onDoubleTap?.call();
        });
      },
      onLongPress: () {
        if (!isFavorite) return;
        setState(() {
          widget.onLongPress();
        });
      },
      child: CustomCard(
        height: 125,
        padding: const EdgeInsets.all(8),
        backgroundColor: context.colorScheme.background,
        showBorder: true,
        borderWidth: isFavorite ? 4 : 1,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderColor: context.colorScheme.primary,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageLinks.smallThumbnail,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset(AssetConfig.bookPlaceHolder),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardContent(
                    title,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(thickness: 1),
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
            ),
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
            style: textStyle,
          )
        : const SizedBox.shrink();
  }
}
