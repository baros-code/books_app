import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../stack/base/presentation/controlled_view.dart';
import '../../../../../shared/presentation/ui/custom/widgets/custom_search_bar.dart';
import '../../../../../shared/presentation/ui/pages/base_page.dart';
import '../../../../../stack/base/presentation/sub_view.dart';
import '../../bloc/books_cubit.dart';
import '../../bloc/books_state.dart';
import '../controllers/favorite_books_page_controller.dart';
import '../custom/widgets/books_page_title.dart';
import '../custom/widgets/favorites_list_view.dart';

class FavoriteBooksPage
    extends ControlledView<FavoriteBooksPageController, Object> {
  FavoriteBooksPage({
    super.key,
    super.params,
  });

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: const BooksPageTitle('Favoriler'),
      backButtonEnabled: true,
      body: _Body(),
    );
  }
}

class _Body extends SubView<FavoriteBooksPageController> {
  @override
  Widget buildView(
    BuildContext context,
    FavoriteBooksPageController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          CustomSearchBar(
            leading: const Icon(Icons.search, size: 30),
            onChange: (value) => controller.searchBooks(value),
          ),
          const SizedBox(height: 8),
          BlocBuilder<BooksCubit, BooksState>(
            buildWhen: (previous, current) => current is BooksUpdated,
            builder: (context, state) {
              final books = state is BooksUpdated
                  ? state.favoriteBooks
                  : controller.books;
              return Expanded(
                child: FavoritesListView(
                  books,
                  onBookLongPress: controller.removeFavorite,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
