import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/presentation/ui/custom/widgets/custom_search_bar.dart';
import '../../../../../shared/presentation/ui/custom/widgets/empty_view.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import '../../bloc/books_cubit.dart';
import '../../bloc/books_state.dart';
import '../controllers/books_page_controller.dart';
import '../custom/widgets/book_card.dart';
import '../custom/widgets/books_page_title.dart';
import '../custom/widgets/paginatable_list_view.dart';
import '../models/book_ui_model.dart';

class BooksPage extends ControlledView<BooksPageController, Object> {
  BooksPage({super.key, super.params});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const BooksPageTitle('Favori Kitaplarım'),
      // Prevents the book icon to move up when keyboard is opened
      resizeToAvoidBottomInset: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite, size: 30),
          onPressed: () => controller.goToFavoritesPage(),
        ),
      ],
      body: _Body(),
    );
  }
}

class _Body extends SubView<BooksPageController> {
  @override
  Widget buildView(BuildContext context, BooksPageController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          CustomSearchBar(
            leading: const Icon(Icons.search, size: 30),
            onSubmitted: (value) => controller.searchBooks(value),
          ),
          const SizedBox(height: 8),
          BlocBuilder<BooksCubit, BooksState>(
            buildWhen: (previous, current) =>
                current is BooksUpdated || current is BooksLoading,
            builder: (context, state) {
              return _buildViews(state, controller);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildViews(BooksState state, BooksPageController controller) {
    final books = state is BooksUpdated ? state.books : controller.books;
    if (books.isEmpty && state is BooksLoading) {
      return const Expanded(
        child: Center(
          child: SizedBox(child: CircularProgressIndicator()),
        ),
      );
    }
    if (books.isEmpty && !controller.isInitialLoading) {
      return const Expanded(
        child: Center(
          child: EmptyView.builder(text: 'Kitap bulunamadı!'),
        ),
      );
    }
    if (books.isEmpty) {
      return const Expanded(
        child: Center(
          child: EmptyView.builder(),
        ),
      );
    }
    return Expanded(
      child: PaginatableListView(
        items: _buildListViewItems(controller, books),
        itemSpacing: 12,
        pageSize: controller.pageSize,
        maxItemCount: controller.maxItemCount,
        errorMessage: 'Kitaplar yüklenirken bir hata oluştu!',
        onPagination: (pageIndex) {
          return controller.fetchBooks(pageIndex);
        },
      ),
    );
  }

  List<PaginatableListViewItem> _buildListViewItems(
    BooksPageController controller,
    List<BookUiModel> items,
  ) {
    return items
        .map(
          (item) => PaginatableListViewItem(
            widget: _buildListViewItem(controller, item),
          ),
        )
        .toList();
  }

  Widget _buildListViewItem(
    BooksPageController controller,
    BookUiModel item,
  ) {
    if (item.isVisible) {
      return BookCard(
        item,
        onDoubleTap: () => controller.addFavorite(item),
        onLongPress: () => controller.removeFavorite(item),
      );
    }
    return const SizedBox.shrink();
  }
}
