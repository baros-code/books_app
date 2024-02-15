import 'book_card.dart';
import '../../../../../../shared/presentation/ui/custom/widgets/empty_view.dart';

import '../../models/book_ui_model.dart';
import 'package:flutter/material.dart';

class FavoritesListView extends StatelessWidget {
  const FavoritesListView(
    this.books, {
    super.key,
    required this.onBookLongPress,
  });

  final List<BookUiModel> books;
  final void Function(BookUiModel) onBookLongPress;

  @override
  Widget build(BuildContext context) {
    return books.isNotEmpty
        ? ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return book.isVisible
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: BookCard(
                        book,
                        // onDoubleTap isn't given because
                        // it's already a favorite
                        onLongPress: () => onBookLongPress(book),
                      ))
                  : const SizedBox.shrink();
            })
        : const Center(child: EmptyView.builder());
  }
}
