import 'package:books_app/features/books/presentation/ui/custom/widgets/book_card.dart';
import 'package:books_app/shared/presentation/ui/custom/widgets/empty_view.dart';

import '../../models/book_ui_model.dart';
import 'package:flutter/material.dart';

class BooksListView extends StatelessWidget {
  const BooksListView(
    this.books, {
    super.key,
    required this.onBookDoubleTap,
    required this.onBookLongPress,
  });

  final List<BookUiModel> books;
  final void Function(BookUiModel) onBookDoubleTap;
  final void Function(BookUiModel) onBookLongPress;

  @override
  Widget build(BuildContext context) {
    return books.isNotEmpty
        ? ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BookCard(
                  book,
                  onDoubleTap: (newBook) => onBookDoubleTap(newBook),
                  onLongPress: (newBook) => onBookLongPress(newBook),
                ),
              );
            })
        : const Center(child: EmptyView.builder());
  }
}
